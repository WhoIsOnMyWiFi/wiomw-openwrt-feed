#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=wiomw
PKG_VERSION:=1.1.2
PKG_RELEASE:=1
PKG_MAINTAINER:=WIOMW Support <support@whoisonmywifi.com>
PKG_LICENSE:=GPL-3.0+
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE_PROTO:=git
PKG_REV:=a8fec5ff6d7fd55d8596417886105b5b5eab2615
PKG_SOURCE_URL:=git://github.com/whoisonmywifi/wiomw-linux.git
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
# add wiomw to init
if [ -z "$${IPKG_INSTROOT}" ]; then
        echo "Enabling rc.d symlink for wiomw"
        /etc/init.d/wiomw enable
fi
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

define Package/wiomw/install
	$(INSTALL_DIR) $(1)/etc/ssl/certs
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/ssl/certs/f081611a.0 $(1)/etc/ssl/certs/
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/wiomw.defaults $(1)/etc/uci-defaults/wiomw-setup
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/wiomw-agent $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/wiomw.init $(1)/etc/init.d/wiomw
endef

$(eval $(call BuildPackage,wiomw))
