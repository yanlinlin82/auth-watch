# auth-watch

Generate or update IP black list by watching /var/log/auth.log

## Usage

1. Checkout the code.

		$ git clone https://github.com/yanlinlin82/auth-watch

2. Setup crontab task.

		$ sudo crontab -e

	Add following line.

		*/10 * * * * bash /path/to/auth-watch/update.sh

	It will check new abuse IP addresses in every 10 minutes.

3. Setup firewall ([netfilter/iptables](http://www.netfilter.org/)).

		$ sudo iptables -N BAN-IP
		$ sudo iptables -A INPUT -j BAN-IP
		$ sudo /path/to/auth-watch/firewall.sh
