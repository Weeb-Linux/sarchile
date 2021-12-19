FROM archarm64:latest

WORKDIR /

# Update pacman.conf file
ADD ./core/configs/pacman_arm64.conf /etc/pacman.conf

# Add dummy resolv.conf file, manager script will
# replace it with acutal resolv.conf file later.
# This is happened because Docker can't hard replace
# it when building image. Please see 
# https://stackoverflow.com/q/41032744
ADD ./core/configs/resolv.conf /etc/resolvconf.conf

# Initialize pacman keyring
RUN pacman-key --init
RUN pacman-key --populate archlinuxarm

# Remove unnecessary packages
RUN pacman -Rns --noconfirm linux-firmware linux-aarch64 openssh

# Update the base image to even with latest official ArchLinuxArm repositories
RUN pacman -Syyu --noconfirm

# Install necessary packages
RUN pacman -S --needed --noconfirm neofetch htop vim wget

# Push build info into /etc/motd file
RUN echo "sarchile Preview" >> /etc/motd
RUN echo "Build date: $(date)" >> /etc/motd
RUN echo "Build variant: aarch64" >> /etc/motd

# Remove /boot directory since the environment
# will never be booted
RUN rm -rf /boot