DISK="/dev/sda"

cd /tmp/stage2

grub-mkconfig -o /boot/grub/grub.cfg
grub-install $DISK

cp -v mirrorlist /etc/pacman.d/mirrorlist
pacman -Syy

cp -v locale.gen /etc/locale.gen
cp -v locale.conf /etc/locale.conf
locale-gen

rm /etc/localtime
ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime

passwd -d root
chsh -s /usr/bin/zsh

systemctl enable NetworkManager

exit
