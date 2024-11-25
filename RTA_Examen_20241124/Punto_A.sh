#!/bin/bash

echo "creacion de LVM,su modificacion, formateo y montado"
sudo lsblk -f
echo "creacion de volumenes fisicos"
sudo pvcreate /dev/sdb /dev/sdc
sudo pvs
echo "creacion de grupos de volumenes"
sudo vgcreate vg_datos /dev/sdb
sudo vgs
sudo vgcreate vg_temp /dev/sdc
sudo vgs
sudo pvs
echo "creacion de volumenes logicos"
sudo lvcreate -L 5M vg_datos -n lv_docker
sudo lvcreate -L 1,5G vg_datos -n lv_workareas
sudo lvcreate -L 512M vg_temp -n lv_swap
sudo lvs
sudo vgs
sudo fdisk -l
echo "se formatean las lvm"
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas
echo "el swap al ser de memoria se formatea y monta con otros comandos"
sudo mkswap /dev/mapper/vg_temp-lv_swap
sudo lsblk -f
sudo swapon /dev/mapper/vg_temp-lv_swap
echo "se montan las otras particiones"
sudo mkdir -p /var/lib/docker/
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker/
sudo mkdir -p /work/
sudo mount /dev/mapper/vg_datos-lv_workareas /work/
df -h
sudo lsblk f
echo "se comprueba q estan montadas las particiones"
