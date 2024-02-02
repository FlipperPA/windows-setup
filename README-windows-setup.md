# Creating a Clean Installation of Windows 11

* These instructions allow you to do a clean install of Windows 11 on a computer. Be sure to back up any data you need before proceeding.
* You will need a USB Drive that is 8 GB or larger.

## Step 1: Create a Bootable Windows Installation USB Drive

This first step has to occur on an existing Windows system. Insert the USB Drive (which will be erased!) into the system.

* [Download the Windows 11 Media Creation Tool](https://go.microsoft.com/fwlink/?linkid=2156295) to the desktop
* Run the program from the desktop
* When it prompts you, select the USB Drive from the dropdown
* It will take about 20 minutes to create the drive

## Step 2 the Easy Way: Automatic Installation

* [Download the Autoattend.xml file](https://raw.githubusercontent.com/FlipperPA/windows-setup/main/Autounattend.xml) and save it to the root of the USB Drive you just created.
    * You may want to edit the file to change the language (`en-US` is chosen).
* Boot to the USB Drive and start the installation.
    * The user account created will be named `admin` with the no password.
    * You can choose which version of Windows 11 to install, and which drive to install Windows on.
    * For a completely fresh install, delete all of the existing partitions, and choose the remaining "Unallocated Space" as your installation location.
        * THIS WILL DELETE ALL DATA ON THE DISK!

![image](https://github.com/FlipperPA/windows-setup/assets/68164/2c9bf551-48d3-49b4-9735-fd38747ee042)

* Once you click the `Next` button, the rest of the installation should happen automatically.

## Step 2 the Hard Way: Manual Installation

If you want to tweak more settings during the process, here's how to do it manually.

* You'll want to make sure the computer doesn't have an internet connection during installation, if possible. Unplug any USB WiFi devices and ethernet cables before installing, or you won't be able to create a local administrator account.
* Insert the USB Drive into the system where you are installing Windows 11.
* **IMPORTANT!** This will wipe all data on this system!
* Turn on the computer and wait for a few minutes while the Windows 11 setup boots from the USB Drive.
    * If it doesn't boot to the Windows 11 setup, you'll need to figure out how to make the system boot from the USB drive.
    * The varies by system, and Google will be your friend here to figure out how to make your system boot to USB.
* Choose your languages and keyboard layout, and click `NEXT`.
* Click `INSTALL NOW`. It'll take a minute for setup to start.
* Check the checkbox to accept the terms, then click `NEXT`.
* Click `CUSTOM`.
* You will see the drive partitions on your hard drive, perhaps only one. Select each one and click DELETE. **IMPORTANT!** This is the step that will delete all data on the computer.
* After you have deleted the partitions, you should see only one entry, which says, `Drive 0 Unallocated Space`. Select it, then click `NEXT`.
* Installation will now start and take about 20 minutes, depending on the speed of your drives. The system will reboot itself; when the system reboot, you can remove the USB Flash Drive.

### After the Reboot

* Select your country or region (defaults to US) and click `YES`.
* Select your keyboard layout (defaults to US) and click `YES`.
* You can add a second keyboard, or most likely click `SKIP`.
* Click `I Don't Have Internet`, even it is isn't true; we want to create a local account.
* Click `Continue With Limited Setup`
* Enter the name of the primary user of the computer, click `NEXT`. The local account will be an Administrator with full rights to this computer.
* Enter a password for the primary user (or leave it blank). Click `NEXT`.
* Turn off the options for `Diagnostic Data`, `Inking & Typing`, `Tailored Experiences`, and `Advertising ID`. Click `ACCEPT`.
* Setup will continue for a few minutes, then you'll be all set to go!
