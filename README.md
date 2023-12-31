# Pilorama
![Pilorama](https://github.com/cppqtdev/Pilorama/blob/main/start/pilorama-3.0.3/assets/cover.png)

![Pilorama-Light](https://github.com/cppqtdev/Pilorama/blob/main/start/pilorama-3.0.3/assets/Light.png)

![Pilorama-Dark](https://github.com/cppqtdev/Pilorama/blob/main/start/pilorama-3.0.3/assets/dark.png)


# <a href="//pilorama.app">Updated Pilorama</a>

*Advanced [Timeboxing](https://en.wikipedia.org/wiki/Timeboxing) Tool*

## Key Features
- Cross-platform software
- Simple countdown timer
- Infinite time boxing timer
- System notifications
- Dynamic tray icon and menu
- JSON Presets
- Night mode


## Installation

[![GitHub Release Version](https://img.shields.io/github/v/release/eplatonoff/pilorama)](https://github.com/eplatonoff/pilorama/releases/latest/) [![GitHub Release Date](https://img.shields.io/github/release-date/eplatonoff/pilorama?label=release%20date)](https://github.com/eplatonoff/pilorama/releases/latest/) [![GitHub Downloads](https://img.shields.io/github/downloads/eplatonoff/pilorama/total)](https://github.com/eplatonoff/pilorama/releases/latest/)

### MacOS and Windows

Precompiled builds are available [here](https://github.com/eplatonoff/pilorama/releases/latest/).

### Linux

> Tip: Archlinux [AUR](https://wiki.archlinux.org/index.php/Arch_User_Repository) package [`pilorama-git`](https://aur.archlinux.org/packages/pilorama-git/) available.

Building from source:

    $ sudo apt install build-essential libqt5svg5-dev qtdeclarative5-dev qml-module-qt-labs-platform qml-module-qt-labs-settings qml-module-qtmultimedia qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtquick-dialogs  # Debian 8 "jessie" and up, Ubuntu 18.04-22.04, Kali Linux 2022.1

    $ git clone git@github.com:cppqtdev/Pilorama.git
    $ cd Pilorama
    $ qmake Basic.pro 
    $ make
    $ ./Basic

