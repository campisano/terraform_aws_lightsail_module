# START CUSTOM init_script.sh
#
# this script assume to be run in a Debian 10
# and keep just a minimal number of packages and its dependencies

export DEBIAN_FRONTEND=noninteractive

apt-get -y update

# mark all packages as "not requested by the user"
apt-mark auto `apt-mark showmanual`

# install or upgrade or at least mark the follow packages as "requested by the user"
apt-get install \
  -o Dpkg::Options::=--force-confold \
  -o Dpkg::Options::=--force-confdef \
  -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
  apt apt-utils bash binutils bsdutils bzip2 coreutils cron debconf debianutils dialog dpkg findutils grep grub-pc gzip ifupdown init iptables isc-dhcp-client kmod less libc-bin locales login lsb-release lsof mount nano openssh-server passwd procps psmisc readline-common rsyslog sed sudo systemd sysvinit-utils tar util-linux

# remove all "not requested" packages
apt-get autoremove -y --purge

apt-get clean

echo "custom init script completed, see  /var/log/cloud-init-output.log for details" > /var/log/init_script.log
sync
shutdown -r +1
