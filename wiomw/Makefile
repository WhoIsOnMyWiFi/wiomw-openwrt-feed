#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=wiomw
PKG_VERSION:=1.0.4-rc1
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_REV:=7fa05758c659764d2fdc04a184a7a54bbcb8a2b8
PKG_SOURCE_URL:=ssh://git.io3o.com/csoutherland/wiomw-linux.git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=${PKG_NAME}-${PKG_VERSION}
PKG_SOURCE_VERSION:=${PKG_REV}

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/wiomw
  SECTION:=admin
  CATEGORY:=Administration
  DEPENDS:=+libmnl +libcurl +yajl +libuci +iptables
  TITLE:=Who Is On My WiFi Agent
  URL:=http://www.whoisonmywifi.com/
  MAINTAINER:=support@whoisonmywifi.com
endef

define Package/wiomw/description
  Who Is On My WiFi is a cloud-based solution for small businesses and
advanced home users to monitor their WiFi-enabled networks. One or
more devices on the network run Who Is On My WiFi agent software to
constantly scan for any other devices and report this data back to the
Who Is On My WiFi cloud. This information can then be analyzed and, if
certain types of agents are used, block an intruder from accessing the
network.

  By installing a Who Is On My WiFi agent directly on the router, you
get both the most reliable information possible and the most powerful
blocking possible.

endef

CONFIGURE_ARGS+= \
	--enable-uci \
	--enable-custom-permanent-iface-blacklist-regex="^lo$$$$" \
	--enable-custom-iptables-path="/usr/sbin/iptables" \
	--enable-custom-agent-type="openwrt" \
	--enable-custom-dnsmasq-lease-file="/var/dhcp.leases" \
	--enable-dnsmasq-lease-lookup \


define Package/wiomw/postinst
#!/bin/sh
# use the new config file if there isn't an old one
if [ -e /etc/config/wiomw ]; then
	echo "Keeping previous wiomw UCI file"
else
	echo "Creating new wiomw UCI file"
	mv /etc/config/wiomw.new /etc/config/wiomw
fi
# add wiomw to init
if [ -z "$${IPKG_INSTROOT}" ]; then
        echo "Enabling rc.d symlink for wiomw"
        /etc/init.d/wiomw enable
fi
# add wiomw to ucitrack
uci -q get ucitrack.@wiomw[0] > /dev/null || {
  uci add ucitrack wiomw > /dev/null
  uci set ucitrack.@wiomw[0].init=wiomw
  uci commit
}
exit 0
endef

define Package/wiomw/prerm
#!/bin/sh
# check if we are on real system
if [ -z "$${IPKG_INSTROOT}" ]; then
        echo "Removing rc.d symlink for wiomw"
        /etc/init.d/wiomw disable
fi
exit 0
endef

define Package/wiomw/postrm
#!/bin/sh
which uci > /dev/null || exit 0
uci -q get ucitrack.@wiomw[0] > /dev/null && {
  uci delete ucitrack.@wiomw[0]
  uci commit
}
endef

define Package/wiomw/conffiles
  /etc/config/wiomw
endef

define Package/wiomw/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/wiomw.conf.example $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/ssl/certs
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/ssl/certs/f081611a.0 $(1)/etc/ssl/certs/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/wiomw.uci $(1)/etc/config/wiomw.new
	$(INSTALL_BIN) ./files/wiomw.defaults $(1)/etc/uci-defaults/wiomw-setup
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/wiomw-agent $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/wiomw.init $(1)/etc/init.d/wiomw
endef

$(eval $(call BuildPackage,wiomw))
