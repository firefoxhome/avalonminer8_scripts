#!/bin/bash
sgdisk -Z /dev/sda
sgdisk -n 1:2048:1050623 -t 1:ef00 /dev/sda
sgdisk -n 2:1050624:968693759 -t 2:8300 /dev/sda
sgdisk -n 3:968693760:976771071 -t 3:8200 /dev/sda
mkfs.ext4 /dev/sda2
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda3
umount /dev/sda2
mount /dev/sda2 /mnt
tar jxvf ./factory821.tar.bz2 -C /mnt
a1=`blkid /dev/sda1 | awk {'print $2'} | sed 's/UUID=//g' | sed 's/"//g'`
a2=`blkid /dev/sda2 | awk {'print $2'} | sed 's/UUID=//g' | sed 's/"//g'`
a3=`blkid /dev/sda3 | awk {'print $2'} | sed 's/UUID=//g' | sed 's/"//g'`
sed -i 's/f1c1ca10-08d4-4963-8ba8-45c0bab79114/'$a2'/g' /mnt/etc/fstab
sed -i 's/f1c1ca10-08d4-4963-8ba8-45c0bab79114/'$a2'/g' /mnt/boot/grub/grub.cfg
sed -i 's/C438-1DAB/'$a1'/g' /mnt/etc/fstab
sed -i 's/22d15316-22ef-4cdf-94dd-5dae3cd9c28e/'$a3'/g' /mnt/etc/fstab
mount --bind /sys /mnt/sys
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount /dev/sda1 /mnt/boot/efi
cd /mnt/
chroot /mnt grub-install --efi-directory=/boot/efi --target=x86_64-efi /dev/sda
sync
reboot








