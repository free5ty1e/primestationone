#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <libusb-1.0/libusb.h>

// Replace these with your controller's IDs
#define SONY_VENDOR_ID 0x054C
#define DUALSHOCK4_PRODUCT_ID_OLD 0x05C4
#define DUALSHOCK4_PRODUCT_ID_NEW 0x09CC

void fatal(char *msg) {
    perror(msg);
    exit(1);
}

int detach_kernel_driver(libusb_device_handle *dev, int interface_number) {
    int res = libusb_detach_kernel_driver(dev, interface_number);
    if (res == LIBUSB_ERROR_NOT_FOUND) {
        printf("Kernel driver already detached from interface %d\n", interface_number);
        return 0;
    } else if (res == LIBUSB_ERROR_ACCESS) {
        printf("Error: Unable to detach kernel driver from interface %d (access error)\n", interface_number);
        return -1;
    } else if (res < 0) {
        printf("Failed to detach kernel driver from interface %d\n", interface_number);
        return res;
    }
    printf("Kernel driver detached from interface %d\n", interface_number);
    return 0;
}

int main(int argc, char *argv[]) {
    libusb_device_handle *dev;
    libusb_device **dev_list;
    libusb_context *context = NULL;
    int res, i;
    ssize_t cnt;
    unsigned char data[16];

    printf("Searching for Sony DualShock 4 controller...\n");

    // Initialize libusb
    res = libusb_init(&context);
    if (res < 0) {
        fatal("libusb initialization failed");
    }

    libusb_set_option(NULL, LIBUSB_OPTION_LOG_LEVEL, LIBUSB_LOG_LEVEL_DEBUG);

    // Get the list of USB devices
    cnt = libusb_get_device_list(context, &dev_list);
    if (cnt < 0) {
        fatal("Failed to get device list");
    }

    // Iterate over the list of devices and try to find the DualShock 4 controller
    for (i = 0; i < cnt; i++) {
        struct libusb_device_descriptor desc;
        res = libusb_get_device_descriptor(dev_list[i], &desc);
        if (res < 0) {
            continue;
        }

        if (desc.idVendor == SONY_VENDOR_ID && 
            (desc.idProduct == DUALSHOCK4_PRODUCT_ID_OLD || desc.idProduct == DUALSHOCK4_PRODUCT_ID_NEW)) {

            printf("DualShock 4 controller found!\n");

            // Open the device
            res = libusb_open(dev_list[i], &dev);
            if (res < 0) {
                printf("Failed to open device\n");
                continue;
            }

            // Iterate over all configurations for the device
            for (int config_idx = 0; config_idx < desc.bNumConfigurations; config_idx++) {
                struct libusb_config_descriptor *config_desc;
                res = libusb_get_config_descriptor(dev_list[i], config_idx, &config_desc);
                if (res < 0) {
                    continue;
                }

                // Iterate over interfaces in this configuration
                for (int interface_idx = 0; interface_idx < config_desc->bNumInterfaces; interface_idx++) {
                    struct libusb_interface_descriptor *interface_desc = &config_desc->interface[interface_idx].altsetting[0];

                    printf("Trying interface %d in configuration %d\n", interface_idx, config_idx);

                    // Detach kernel driver if it's attached
                    if (detach_kernel_driver(dev, interface_desc->bInterfaceNumber) < 0) {
                        continue;
                    }

                    // Attempt to claim the interface
                    res = libusb_claim_interface(dev, interface_desc->bInterfaceNumber);
                    if (res < 0) {
                        printf("Failed to claim interface %d (error %d)\n", interface_desc->bInterfaceNumber, res);
                        continue;
                    }

                    // Prepare the packet with the Raspberry Pi's Bluetooth MAC address
                    unsigned char bt_mac[6] = {0x00, 0x1A, 0x7D, 0xDA, 0x71, 0x13}; // Replace with your Pi's MAC
                    memset(data, 0, sizeof(data));
                    data[0] = 0x13;  // Command identifier
                    data[1] = 0x37;  // Magic number (example, might need to adjust)
                    memcpy(&data[2], bt_mac, 6);

                    printf("Setting Bluetooth master to %02X:%02X:%02X:%02X:%02X:%02X\n",
                           bt_mac[0], bt_mac[1], bt_mac[2], bt_mac[3], bt_mac[4], bt_mac[5]);

                    // Send the packet
                    res = libusb_control_transfer(dev,
                                                  LIBUSB_REQUEST_TYPE_CLASS | LIBUSB_RECIPIENT_INTERFACE,
                                                  0x09,  // HID SET_REPORT
                                                  (0x03 << 8) | 0xF4,  // Report Type (Feature) and Report ID
                                                  interface_desc->bInterfaceNumber,  // Interface
                                                  data,
                                                  sizeof(data),
                                                  0);
                    if (res < 0) {
                        printf("Failed to send control transfer (interface %d, config %d)\n", interface_idx, config_idx);
                    } else {
                        printf("Bluetooth master address set successfully on interface %d, config %d!\n", interface_idx, config_idx);
                        libusb_release_interface(dev, interface_desc->bInterfaceNumber);
                        break;  // Exit after successful transfer
                    }
                }
            }

            // Close the device and break out of the loop
            libusb_close(dev);
            break;
        }
    }

    // Clean up
    libusb_free_device_list(dev_list, 1);
    libusb_exit(context);

    return 0;
}
