FROM archarm:latest

WORKDIR /

# Add dummy resolv.conf file, manager script will
# replace it with acutal resolv.conf file later.
# This is happened because Docker can't hard replace
# it when building image. Please see 
# https://stackoverflow.com/q/41032744
ADD conf/resolv.conf /etc/resolvconf.conf

# Initialize pacman keyring
RUN pacman-key --init
RUN pacman-key --populate archlinuxarm

# Remove unnecessary packages
RUN pacman -Rns linux-firmware linux-aarch64 --noconfirm

# Update the base image to even with latest official ArchLinuxArm repositories
RUN pacman -Syyu --noconfirm

# Install necessary packages
RUN pacman -S --needed neofetch htop vi vim wget curl ncurses

# Remove /boot directory since the environment
# will never be booted
RUN rm -rf /boot