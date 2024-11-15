#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
##-----------------Add OpenClash dev core------------------
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1
echo "src/gz kenzok8 https://op.dllkids.xyz/packages/aarch64_cortex-a53" >> package/system/opkg/files/customfeeds.conf
sed -i 's/^option check_signature/#option check_signature/' package/system/opkg/files/opkg.conf
# 在 libxcrypt 的 Makefile 中将 PKG_FORTIFY_SOURCE 设置为 0
sed -i 's/^PKG_FORTIFY_SOURCE:=.*$/PKG_FORTIFY_SOURCE:=0/' feeds/packages/libs/libxcrypt/Makefile
##---------------------------------------------------------
