# START CUSTOM SECTION init_script.sh
#
# this script assume to be run in a Debian 10 AWS image (that will copy-paste this script in a bigger one)
# and keep just a minimal number of packages and its dependencies

export DEBIAN_FRONTEND=noninteractive

apt-get -y update

# mark all packages as "not requested by the user"
apt-mark auto `apt-mark showmanual`

# install or upgrade or at least mark the follow packages as "requested by the user"
apt-get -y -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-confdef install \
  apt apt-utils bash binutils bsdutils bzip2 coreutils cron debconf debianutils dialog dpkg findutils grep grub-pc gzip ifupdown init iptables isc-dhcp-client kmod less libc-bin locales login lsb-release lsof mount nano openssh-server passwd procps psmisc readline-common rsyslog sed sudo systemd sysvinit-utils tar util-linux

# remove all "not requested" packages
apt-get -y autoremove --purge
apt-get -y dist-upgrade
apt-get -y clean
sync

echo "custom init script completed, see /var/log/cloud-init-output.log for details" > /var/log/init_script.log

# restart in a minute, just giving the time to complete other stuffs for the first boot
shutdown -r +1

# END CUSTOM SECTION init_script.sh
