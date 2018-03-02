#!/bin/bash
sgdisk -Z /dev/sda
sgdisk -n 1:2048:1050623 -t 1:ef00 /dev/sda
sgdisk -n 2:1050624:838860800 -t 2:8300 /dev/sda
sgdisk -n 3:838860801:859832320 -t 3:8200 /dev/sda
mkfs.ext4 /dev/sda2
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda3
umount /dev/sda2
mount /dev/sda2 /mnt
tar jxvf ./testsudo.tar.bz2 -C /mnt
a1=`blkid /dev/sda1 | awk {'print $2'} | sed 's/UUID=//g' | sed 's/"//g'`
a2=`blkid /dev/sda2 | awk {'print $2'} | sed 's/UUID=//g' | sed 's/"//g'`
a3=`blkid /dev/sda3 | awk {'print $2'} | sed 's/UUID=//g' | sed 's/"//g'`
sed -i 's/45711b03-2a1f-42c5-9fc0-37f58d31677c/'$a2'/g' /mnt/etc/fstab
sed -i 's/45711b03-2a1f-42c5-9fc0-37f58d31677c/'$a2'/g' /mnt/boot/grub/grub.cfg
sed -i 's/3303-2102/'$a1'/g' /mnt/etc/fstab
sed -i 's/fb87bfcd-a10d-4793-bcf6-e6e8ff70617f/'$a3'/g' /mnt/etc/fstab
mount --bind /sys /mnt/sys
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount /dev/sda1 /mnt/boot/efi
cd /mnt/
chroot /mnt grub-install --efi-directory=/boot/efi --target=x86_64-efi /dev/sda
sync
reboot








