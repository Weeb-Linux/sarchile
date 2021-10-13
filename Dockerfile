FROM archarm:latest

WORKDIR /

# Update pacman.conf file
ADD conf/pacman.conf /etc/pacman.conf

# Fix resolv.conf file
ADD conf/resolv.conf /etc/resolv.conf

# Initialize pacman keyring
RUN pacman-key --init
RUN pacman-key --populate archlinuxarm

# Remove unnecessary packages
RUN pacman -Rns linux-firmware linux-aarch64 --noconfirm

# Update the base image to even with latest official ArchLinuxArm repositories
RUN pacman -Syyu --noconfirm

# Nuke locale directory
RUN rm -rf /usr/share/locale
# Readd locale.alias so we can generate locale again
ADD conf/locale.alias /usr/share/locale/locale.alias
# Update custom locale.gen file, default to en_US.UTF-8
ADD conf/locale.gen /etc/locale.gen
# and generate the locale
RUN locale-gen

# Set language to American English
ADD conf/locale.conf /etc/locale.conf

# Fix directories permission to match with packages
RUN chmod -R 755 /etc
RUN chmod -R 755 /usr
RUN chmod -R 755 /var


CMD ["/usr/bin/bash"]