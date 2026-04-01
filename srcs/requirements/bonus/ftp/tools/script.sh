#!/bin/sh

mkdir -p /var/run/vsftpd/empty

if ! [ -f "/etc/vsftpd.done" ]; then
	echo "Première initialisation de vsftpd ..."

	adduser $FTP_USER --disabled-password --home /var/www/wordpress --gecos ""

	FTP_PASSWORD=$(cat /run/secrets/ftp_password)
	echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd

	# Ajout à la liste des utilisateurs autorisés
	echo "$FTP_USER" | tee -a /etc/vsftpd.userlist

	usermod -aG www-data $FTP_USER

	sed -i -r "s/#write_enable=YES/write_enable=YES/1" /etc/vsftpd.conf
	sed -i -r "s/#chroot_local_user=YES/chroot_local_user=YES/1" /etc/vsftpd.conf

	echo "local_enable=YES
allow_writeable_chroot=YES
pasv_enable=YES
# On pointe directement la racine du FTP vers WordPress
local_root=/var/www/wordpress
pasv_min_port=40000
pasv_max_port=40005
userlist_file=/etc/vsftpd.userlist
background=NO
seccomp_sandbox=NO
local_umask=002
file_open_mode=0777" >> /etc/vsftpd.conf

	touch /etc/vsftpd.done
	echo "Initialisation terminée."
fi

/usr/sbin/vsftpd
