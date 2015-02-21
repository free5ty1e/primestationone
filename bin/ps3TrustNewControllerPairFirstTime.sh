#!/bin/bash

cowsay -f calvin Tool to trust a new PS3 controller for the first time...
echo .
echo You are about to enter the bluetooth command console, unfortunately required to trust new PS3 controllers for the first time...
echo After this is completed for a controller, you should only have to plug it into the Primestation via USB to pair bluetooth after using it on a real PS3.
echo .
echo .
echo Ensure the PS3 controller you want to trust with the Primestation is connected via USB cable before proceeding!
echo You should see your New device PLAYSTATION3 Controller listed before the prompt if all is normal.
echo .
echo First, type:
echo agent on
echo .
echo Then, type:
echo default-agent
echo .
echo Then, disconnect your PS3 controller from the USB and press the PS3 button...
echo .
echo When asked to trust the new connection, say yes!
echo .
echo From this point on, you should be able to plug in via USB to reset THIS controller after using it on a PS3, and pair whenever needed by simply pressing the PS3 button on the controller... just like a PS3 - plug in via USB to set the controller to THIS PS3, then wireless works...
echo .
echo You will have to repeat this procedure for EACH NEW PS3 CONTROLLER that this Primestation has never seen before!
echo .
echo You can then type quit to quit... which I thought was rather clever...
sudo bluetoothctl
agent on
default-agent
