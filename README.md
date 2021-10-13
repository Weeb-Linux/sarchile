# IMPORTANT: The project is still under heavy development. We force push a lot!
Join our [Telegram channel](https://t.me/joinchat/ol_1uKptA1ZiNWU1) now to stay up to date with main developer.
# sarchile

**S**imple **Arch** Linux on mob**ile**

## Introduction

This (project, maybe?) is a set of quick and simple scripts to help you run a small, versatile Arch Linux on your Android. And yea, we uses Termux with proot.

## System requirements

There is no actual hardware or software minimal requirement to install sarchile. If your phone can install and work with Termux then you are pretty fine to go.

However, to ensure the best experience, your device should...

- Have at least 2GB of storage to install sarchile, but for a more daily using we suggest 8GB of storage or higher.
- sarchile itself uses nearly no memory at idle, but 4GB of device ram is recommended. Because your Android system (and other Android apps) could've take a plenty of memory already.

# Instructions

Note: make sure you have installed Termux from **F-Droid**, **not** from Google Play as Termux is leaving Google Play due to new Android system API issues. If you installed Termux from Google Play, high chance it's outdated and we never test on that version anymore.

You can start install sarchile either right after you install Termux or on your current Termux. 

For setup preparation, you only do a simple command before installation:

```
pkg install curl -y
```

Execute the installation script (remotely):

```
curl -Lso- https://git.io/JKJrl | bash
```

This will install the managemnent script. To begin with sarchile installation, do:

```
smgr install
```

## Master guide

This project consists of two main script files: 

- Initiation script (`initscript.sh`): this script will install some required Termux packages then download and install the management script. This script won't be saved on device.
- Management script (`smgr.sh`): this script will...
    - Download, install the Arch image into Termux storage; preinstall many necessary packages for the ease of use for sarchile and create `sarchile` command to start it up.
    - Let user to self-uninstall sarchile.
    - Some expected functionalities are listed in [TODOs](#todos).

## Contribution guide

Simply clone/fork this repository and explore on yourself. Scripts are really simple to read if you're familiar with shell script language. Do the PR when you're ready.

## Bug report/Feature request guide

If you found an unexpected behavior/bug/error/feature request that is not included in [TODOs](#todos) list, please feel free to make an issue. But you must follow some rules:
- Your issue must be sanity and long enough for us to understand what you want.
- Screenshot/debug log is necessary for shooting the bug, sometimes is required.
- If you request feature in a nonsense way or trolling. We will find a way that you can't talk to us anymore(TM).

# Some FAQ and predicted misunderstandings

1. **We do not work with chroot, only proot.** We're already known about chroot (requires Android system is rooted) will bring better performance. But our time and effort are extremely limited to test and make sure it won't harm your device.

2. **We are not making any distro based on Arch (for mobile)**.

3. We started this project because we found [TermuxArch](https://github.com/TermuxArch/TermuxArch) is way too complicated to setup and the documents are non-sense to tell you what's going on.

4. We only work with aarch64 variant of Arch Linux (aka arm64, arm64-v8a) or simply, your Android system is running on an 64-bit ARM architecture processor.

5. This project is in no way affiliated with Arch Linux team or any of its community. But we still seek for friendship and contribution from anyone. We also do not expect to bring this project to any of Arch Repository.

6. "Should I read archwiki t.." -Yes, if you work with anything that is related to Arch Linux, you ~~should~~ must read the Arch Wiki.

7. **Your phone is a phone, not a PC nor a workstation**. So please do not push your device to work beyond it's limitations.

8. **Battery draining faster** is expected, but won't too hard. You also should take care of your phone battery!

# TODOs

- [ ] SHA256 checksum to verify image integrity.
- [ ] Add ability to verify if environment satisties with requirements in initialization script.
- [ ] Rewrite a better management script.

# Donation
- [PayPal](https://paypal.me/iamwello).
- For donation from Vietnam. Please contact me via [Telegram](https://t.me/wello6143).