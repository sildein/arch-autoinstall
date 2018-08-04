# Disk to install Arch on. CHECK BEFORE RUNNING.
DISK="/dev/sda"

pacman -Sy git --noconfirm
git clone https://github.com/sildein/arch-autoinstall

parted -s -a optimal $DISK mklabel msdos
parted -s -a optimal $DISK mkpart primary ext4 0% 100%
mkfs.ext4 -m 0 ${DISK}1

mount -o rw,noatime ${DISK}1 /mnt

pacstrap /mnt base \
              base-devel \
              grub \
              zsh \
              openssh \
              networkmanager \
              vim \
              git \
              python \
              pulseaudio

genfstab -U /mnt > /mnt/etc/fstab

cp -v /etc/zsh/zshrc > /mnt/etc/zsh
cd /mnt/tmp
cp -rv ~/arch-autoinstall/stage2 /mnt/tmp

arch-chroot /mnt /bin/bash /tmp/stage2/install-2.sh

reboot
