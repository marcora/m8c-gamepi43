# m8c-gamepi43

[![Dirtywave M8 headless tracker on Waveshare GamePi43](https://img.youtube.com/vi/3J18RanrJd4/0.jpg)](https://www.youtube.com/watch?v=3J18RanrJd4)

# Hardware

I made the device you see in the video above using the following hardware components:

- [Raspberry Pi 4 (8GB)](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/)
- [microSD card for Raspberry Pi OS (goes into the GamePi43 microSD card reader slot)](https://www.amazon.com/gp/product/B08F7Y4R1B)
- [Waveshare GamePi43](https://www.waveshare.com/GamePi43-Acce-US.htm)
- [18650 rechargeable batteries](https://www.amazon.com/gp/product/B08RDL44MX)
- [Teensy 4.1 board](https://www.pjrc.com/store/teensy41.html)
- [Teensy 4.1 case](https://www.thingiverse.com/thing:4965543) mounted to the back of the GamePi43 with [Gorilla tape](https://www.amazon.com/gp/product/B019HT1U9E)
- [microSD card for Dirtywave M8 (goes into the Teensy 4.1 microSD card reader slot)](https://www.amazon.com/gp/product/B089W2VGC4)
- [Short USB A to Micro USB cable](https://www.amazon.com/gp/product/B013G4D2OM)

# Software

## Acknowledgements

First and foremost, huge thanks to the authors, developers and contributors of the following resources:

- https://github.com/Dirtywave/M8HeadlessFirmware
- https://www.waveshare.com/wiki/GamePi43
- https://github.com/recalbox/mk_arcade_joystick_rpi
- https://github.com/sigrokproject/libserialport
- https://github.com/laamaa/m8c and https://github.com/laamaa/m8c/issues/20
- https://github.com/laamaa/m8c/blob/main/AUDIOGUIDE.md
- https://github.com/rasprague/m8c-piboy
- https://www.matteomattei.com/web-kiosk-with-raspberry-pi-and-read-only-sd/
- http://matchbox-project.org/
- https://jackaudio.org/
- https://www.raspberrypi.com/for-home/
- https://www.pjrc.com/store/teensy41.html

without whom none of what is explained here would be possible! :)

## Step 1: Install Raspberry Pi OS Lite (Legacy)

First, you need to install Raspberry Pi OS to its microSD card using the [Raspberry Pi Imager](https://www.raspberrypi.com/software/).

**Make sure to install Raspberry Pi OS Lite (Legacy)** and to enable ssh and wifi in the advanced options, if you plan to login remotely and wirelessly into your Raspberry Pi (recommended).

Reinsert the microSD card into your computer, open the `config.txt` file in the `boot` directory of the microSD card, add the following code at the end of `config.txt`:

```
max_usb_current=1
hdmi_force_hotplug=1
hdmi_group=2
hdmi_mode=87
hdmi_cvt=800 480 60 6 0 0 0
```

then save and eject the microSD card safely from your computer.

Insert the microSD card into the GamePi43 microSD card reader slot and switch on the device.

Login into your Raspberry Pi and update/upgrade the OS:

```sh
sudo apt update
sudo apt upgrade
sudo reboot
```

Login again and set the locale to en_US.UTF-8 using the `raspi-config` tool:

```sh
sudo raspi-config
```

Exit `raspi-config` and reboot:

```sh
sudo reboot
```

Login again and finish setting the locale:

```sh
sudo update-locale LC_ALL="en_US.UTF-8"
sudo update-locale LANGUAGE="en_US"
sudo reboot
```

Login again and check that your Raspberry Pi OS locale is properly set by typing the command `locale` and making sure it returns the following:

```
LANG=en_US.UTF-8
LANGUAGE=en_US:en
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=en_US.UTF-8
```

## Step 2: Install `RetroPie-Setup` and the arcade joystick driver

Install the packages needed to install `RetroPie-Setup`:

```sh
sudo apt install git lsb-release
```

Download the latest `RetroPie-Setup` script:

```sh
cd
git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
```

and execute it:

```
cd RetroPie-Setup
chmod +x retropie_setup.sh
sudo ./retropie_setup.sh
```

Select the `Manage Packages` and then the `driver` options and install the `mkarcadejoystick` from source.

Exit `RetroPie-Setup` and reboot:

```sh
sudo reboot
```

Login again and check that your joystick is properly set by typing the command `less /etc/modprobe.d/mk_arcade_joystick_rpi.conf` and making sure it returns the following:

```
options mk_arcade_joystick_rpi map=1
```

## Step 3: Install Matchbox window manager

Install the Matchbox window manager:

```sh
sudo apt install --no-install-recommends xserver-xorg x11-xserver-utils xinit matchbox-window-manager joystick
```

Add `tty` group to `pi` user:

```sh
sudo gpasswd -a pi tty
sudo sed -i '/^exit 0/c\chmod g+rw /dev/tty?\nexit 0' /etc/rc.local
```

and reboot:

```sh
sudo reboot
```

## Step 4: Install `m8c` for GamePi43

Login again and install the packages needed to compile and install `m8c` (and `libserialport`):

```sh
sudo apt install git gcc make libsdl2-dev
```

```sh
sudo apt install autotools-dev autoconf libtool
```

Download the source code for `libserialport`:

```sh
cd
git clone https://github.com/sigrokproject/libserialport.git
```

and compile + install it:

```sh
cd libserialport
./autogen.sh
./configure
make
sudo make install
```

```sh
sudo ln -s /usr/local/lib/libserialport.so.0.1.0 /usr/lib/libserialport.so.0.1.0
sudo ln -s /usr/local/lib/libserialport.so.0 /usr/lib/libserialport.so.0
```

Download the source code for `m8c`:

```sh
cd
git clone https://github.com/marcora/m8c-gamepi43.git
```

and compile + install it:

```sh
cd m8c-gamepi43
make
sudo make install
```

## Step 5: Install Dirtywave M8 headless tracker onto the Teensy and connect it to the GamePi43

Follow steps 1 and 2 (not 3 and 4) of [these instructions](https://github.com/DirtyWave/M8Docs/blob/main/docs/M8HeadlessSetup.md) to install the Dirtywave M8 headless tracker onto the Teensy microSD card, insert it into the Teensy and then connect the Teensy to the GamePi43 using the USB cable.

## Step 6: Install JACK to connect audio from the Teensy to the GamePi43

Install JACK to connect audio from the Teensy to the GamePi43 (answer `Yes` when asked to "Enable realtime process priority?"):

```sh
sudo apt install jackd2
```

Add `audio` group to `pi` user:

```sh
sudo usermod -a -G audio pi
```

and reboot:

```sh
sudo reboot
```

## Setup GamePi43 to auto-login and launch `m8c` with the MatchBox window manager

Login again and start `m8c`, it should automatically detect your Teensy:

```sh
m8c
```

Kill `m8c` with `Ctrl+C`.

Copy `m8c` configuration files to `.local/share/m8c`:

```sh
cd
cp m8c-gamepi43/config.ini .local/share/m8c
cp m8c-gamepi43/gamecontrollerdb.txt .local/share/m8c
```

Link `m8c` launcher script to your `home` directory:

```sh
cd
ln -s m8c-gamepi43/m8c.sh .
```

Open the `.bashrc` file in your `home` directory:

```sh
cd
nano -w .bashrc
```

and add the following code at the end of it:

```
if [ -z "${SSH_TTY}" ]; then
  xinit ~/m8c.sh
fi
```

save the file and close the text editor with `Ctrl+X`.

Set the Raspberry Pi OS to automatically login to console using the `raspi-config` tool:

```sh
sudo raspi-config
```

Exit `raspi-config` and reboot:

```sh
sudo reboot
```

Upon reboot, if everything was done correctly, the GamePi43 will auto-login, launch `m8c`, and connect the audio.

In order to kill `m8c` and power off the device, press (X + Y + DownArrow) and move the power switch to off.

After all of this, I prefer to disable wifi and bluetooth to extend battery life and, when I need access to the Raspberry Pi OS on the GamePi43, ssh using direct connection via ethernet cable. To disable wifi and bluetooth add the following lines at the end of `/boot/config.txt` and reboot:

```
dtoverlay=disable-wifi
dtoverlay=disable-bt
```

## Where to go from here?

If you are interested in adding the Dirtywave M8 headless tracker as an "app" in RetroPie or if you are interested in more complex launcher scripts and setups, please see the excellent work by Richard "spike" Sprague at https://github.com/rasprague/m8c-piboy that has been the source of inspiration for this project of mine.
