# Clean Arch image for testing package installation (right deps and stuff)

FROM archlinux:latest

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm git sudo base-devel go 

RUN useradd user && usermod -aG wheel user
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN mkdir /home/user && chown -R user:user /home/user

USER user
WORKDIR /tmp
RUN git clone https://aur.archlinux.org/yay.git
RUN cd yay && makepkg -sri --noconfirm && cd .. && rm -rf yay

WORKDIR /home/user
RUN yay

# docker build -t arch_pkg .
# docker run -it arch_pkg yay -S <pkg_name>
