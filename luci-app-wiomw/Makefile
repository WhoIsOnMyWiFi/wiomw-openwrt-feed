#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-wiomw
PKG_VERSION:=1.0.4-rc1
PKG_RELEASE:=2
LUCI_DIR:=/usr/lib/lua/luci

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-wiomw
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=Who Is On My WiFi Agent LuCI Interface
  MAINTAINER:=support@whoisonmywifi.com
  PKGARCH:=all
  DEPENDS:=+lua +luci-lib-core +wiomw
  SUBMENU:=3. Applications
endef

define Package/luci-app-wiomw/description
  Configure the Who Is On My WiFi agent from a web browser.
endef

define Build/Compile
endef

define Build/Configure
endef

define Package/luci-app-wiomw/install
	$(INSTALL_DIR) $(1)$(LUCI_DIR)/controller $(1)$(LUCI_DIR)/model/cbi/wiomw $(1)$(LUCI_DIR)/view/wiomw
	$(INSTALL_DATA) ./files/wiomw-controller.lua $(1)$(LUCI_DIR)/controller/wiomw.lua
	$(INSTALL_DATA) ./files/wiomw-cbi.lua $(1)$(LUCI_DIR)/model/cbi/wiomw/basic.lua
	$(INSTALL_DATA) ./files/wiomw-login.htm $(1)$(LUCI_DIR)/view/wiomw/login.htm
endef

$(eval $(call BuildPackage,luci-app-wiomw))

