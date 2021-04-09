WIFI_COUNTRY=HR
SSID=wlan
WPA_PASS=password

.PHONY=init
.PHONY=activate
.PHONY=deactivate
init:
	@echo "WARNING: the following code is intended to be run once. running it multiple times may lead to file corruption or malfunction. use at your own risk"
	ap install hostapd
	systemctl unmask hostapd
	systemctl enable hostapd
	apt install dnsmasq
	apt install -y netfilter-persistent iptables-persistent
	printf "interface wlan0\n\tstatic ip_address=192.168.4.1/24\n\tnohook wpa_supplicant" >> /etc/dhcpcd.conf
	mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
	printf "interface=wlan0\ndhcp-range=192.168.4.2,192.168.4.20,255.255.255.0,24h\ndomain=wlan\naddress=/gw.wlan/192.168.4.1" > /etc/dnsmasq.conf
	printf "country_code=$(WIFI_COUNTRY)\ninterface=wlan0\nssid=$(SSID)\nhw_mode=g\nchannel=7\nmacaddr_acl=0\nauth_algs=1\nignore_broadcast_ssid=0\nwpa=2\nwpa_passphrase=$(password)\nwpa_key_mgmt=WPA-PSK\nwpa_pairwise=TKIP\nrsn_pairwise=CCMP" >> /etc/hostapd/hostapd.conf
	systemctl reboot
activate:
	systemctl unmask hostapd
	systemctl enable hostapd
	systemctl reboot
deactivate:
	systemctl disable hostapd
	systemctl mask hostapd
	systemctl disable dnsmasq
	systemctl reboot
