FROM ubuntu:14.04
MAINTAINER Liu Songpeng <13916688528@139.com>

RUN \
	echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse"> /etc/apt/sources.list && \
	echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse">> /etc/apt/sources.list && \
	echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse">> /etc/apt/sources.list && \
	echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse">> /etc/apt/sources.list && \
	echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse">> /etc/apt/sources.list && \
	echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse">> /etc/apt/sources.list && \
	echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse">> /etc/apt/sources.list && \
	echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse">> /etc/apt/sources.list && \
	echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse">> /etc/apt/sources.list && \
	echo "deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse">> /etc/apt/sources.list && \
	apt-get update && \
	apt-get install -y netmask isc-dhcp-server

ADD dhcpd.sh /dhcpd
ADD dhcpd.conf /default_dhcpd.conf
RUN chmod +x /dhcpd

EXPOSE 67/udp

VOLUME	["/conf"]

ENTRYPOINT ["/dhcpd"]
CMD ["-f", "-cf", "/data/dhcpd.conf", "-lf", "/data/dhcpd.leases", "--no-pid"]
