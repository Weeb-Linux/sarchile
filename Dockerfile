FROM archarm:latest

WORKDIR /archlinux

RUN mkdir -p /archlinux/rootfs

COPY pacstrap-docker /archlinux/

RUN ./pacstrap-docker /archlinux/rootfs \
	bash sed gzip pacman

# Remove current pacman database, likely outdated very soon
RUN rm rootfs/var/lib/pacman/sync/*

FROM scratch
COPY --from=0 /archlinux/rootfs/ /
COPY rootfs/ /

RUN pacman-key --init
RUN pacman-key --populate archlinuxarm
RUN pacman -Rns linux-firmware linux-aarch64
RUN pacman -Syyu --noconfirm

CMD ["/usr/bin/bash"]