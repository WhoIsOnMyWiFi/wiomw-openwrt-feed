#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=wiomw-sui
PKG_VERSION:=0.2.16
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_REV:=afa1058f0188e766a24193c6920b6265502fc203
PKG_SOURCE_URL:=ssh://git.io3o.com/csoutherland/openwrt-sui.git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=${PKG_NAME}-${PKG_VERSION}
PKG_SOURCE_VERSION:=${PKG_REV}

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/wiomw-sui
  SECTION:=admin
  CATEGORY:=Administration
  DEPENDS:=+wiomw +uhttpd +yajl +libuci +libpolarssl +libcurl
  TITLE:=Simple UI (includes Who Is On My WiFi)
  URL:=http://www.whoisonmywifi.com/
  MAINTAINER:=support@whoisonmywifi.com
endef

define Package/wiomw-sui/description
  Simple UI is an extremely simple web interface for OpenWRT. It includes an interface for Who Is On My WiFi.
endef

CONFIGURE_ARGS+= \
		--without-fcgi \
		--bindir=/www/cgi-bin \
		--with-release=$(PKG_RELEASE)

define Package/wiomw-sui/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/sui.defaults $(1)/etc/uci-defaults/sui-setup
	$(INSTALL_DIR) $(1)/www
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www-static/index.html $(1)/www/
	$(INSTALL_DIR) $(1)/www/cgi-bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/www/cgi-bin/*.cgi $(1)/www/cgi-bin/
	$(INSTALL_DIR) $(1)/www/css
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www-static/css/*.css $(1)/www/css
	$(INSTALL_DIR) $(1)/www/js
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www-static/js/*.js $(1)/www/js
endef

$(eval $(call BuildPackage,wiomw-sui))
