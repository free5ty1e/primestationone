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

int main(int argc, char *argv[]) {
    libusb_device_handle *dev;
    int res;
    unsigned char data[16];

    printf("Searching for Sony DualShock 4 controller...\n");

    // Initialize libusb
    res = libusb_init(NULL);
    if (res < 0) {
        fatal("libusb initialization failed");
    }

    libusb_set_option(NULL, LIBUSB_OPTION_LOG_LEVEL, LIBUSB_LOG_LEVEL_DEBUG);

    // Open the DualShock 4 controller (either old or new model)
    dev = libusb_open_device_with_vid_pid(NULL, SONY_VENDOR_ID, DUALSHOCK4_PRODUCT_ID_OLD);
    if (!dev) {
        dev = libusb_open_device_with_vid_pid(NULL, SONY_VENDOR_ID, DUALSHOCK4_PRODUCT_ID_NEW);
    }
    if (!dev) {
        fatal("No compatible DualShock 4 controller found. Is it connected via USB?");
    }

    printf("DualShock 4 controller found!\n");

    // Detach kernel driver if necessary
    // if (libusb_kernel_driver_active(dev, 0)) {
        res = libusb_detach_kernel_driver(dev, 0);
        if (res != 0) {
            printf("Warning: Could not detach kernel driver (error %d)\n", res);
        } else {
            printf("Kernel driver detached successfully.\n");
        }
    // }

    // Claim the interface
    res = libusb_claim_interface(dev, 0);
    if (res < 0) {
        fatal("Failed to claim interface");
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
                                  0,                   // Interface
                                  data,
                                  sizeof(data),
                                  0);
    if (res < 0) {
        fatal("Failed to send control transfer");
    }

    printf("Bluetooth master address set successfully!\n");

    // Release and close the device
    libusb_release_interface(dev, 0);
    libusb_close(dev);
    libusb_exit(NULL);

    return 0;
}
