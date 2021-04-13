# Clean Arch image for testing package installation 
FROM archlinux:latest AS aur-base

RUN pacman -Syyuu --noconfirm
RUN pacman -S --noconfirm git sudo base-devel pacman-contrib go

RUN useradd user && usermod -aG wheel user
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN mkdir /home/user && chown -R user:user /home/user

USER user
RUN git clone https://aur.archlinux.org/yay.git /tmp/yay \
	&& cd /tmp/yay 			\
	&& makepkg -sri --noconfirm	\
	&& rm -rf /tmp/yay


FROM aur-base AS yay-image

RUN yay -S --noconfirm --needed yay \
	&& yay --noconfirm --clean  \
	&& paccache -vrfk0

WORKDIR /home/user
ENTRYPOINT ["/usr/bin/yay"]

# docker build -t yayimage .
# docker run -it yayimage -S <pkg_name>
