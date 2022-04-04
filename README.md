# m8c-gamepi43

[![Dirtywave M8 headless tracker on Waveshare GamePi43](https://img.youtube.com/vi/3J18RanrJd4/0.jpg)](https://www.youtube.com/watch?v=3J18RanrJd4)

# Installation

These instructions are tested with Raspberry Pi 4.

Open Terminal and run the following commands:

### Install required packages (Raspberry Pi, Linux)

```
sudo apt update && sudo apt install -y git gcc make libsdl2-dev
```
### Download source code (All)

```
mkdir code && cd code
git clone https://github.com/marcora/m8c-gamepi43.git
```

### Build the program

```
cd m8c
make
```

### Start the program

Connect the M8 or Teensy (with headless firmware) to your computer and start the program. It should automatically detect your device.

```
./m8c
```

If the stars are aligned correctly, you should see the M8 screen.
