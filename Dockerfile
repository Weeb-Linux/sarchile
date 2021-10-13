FROM archarm:latest

WORKDIR /

# Initialize pacman keyring
RUN pacman-key --init
RUN pacman-key --populate archlinuxarm

# Remove unnecessary packages
RUN pacman -Rns linux-firmware linux-aarch64

# Update the base image to even with latest official ArchLinuxArm repositories
RUN pacman -Syyu --noconfirm

# Update pacman.conf file
ADD conf/pacman.conf /etc/pacman.conf

# Fix resolv.conf file
RUN rm /etc/resolv.conf
ADD conf/resolv.conf /etc/resolv.conf

# Fix directories permission to match with packages
RUN chmod -R 755 /etc
RUN chmod -R 755 /usr
RUN chmod -R 755 /var


CMD ["/usr/bin/bash"]