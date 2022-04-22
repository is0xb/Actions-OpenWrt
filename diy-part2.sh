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
sed -i 's/192.168.1.1/172.16.1.1/g' package/base-files/files/bin/config_generate
sed -i 's/0.openwrt.pool.ntp.org/time.pool.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/1.openwrt.pool.ntp.org/ntp1.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/OpenWrt-0/g' package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/OpenWrt-xx/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh


cat>>package/network/config/firewall/files/firewall.config<<EOF

# forward web port 80 at 9666
config redirect                      
        option dest 'lan'               
        option target 'DNAT'                    
        option name 'route9666'                    
        list proto 'tcp'              
        option src 'wan'              
        option src_dport '9666'                 
        option dest_port '80'          
        option dest_ip '172.16.1.1' 

# forward ssh port 22 at 9222
config redirect                        
        option dest 'lan'                         
        option target 'DNAT'         
        option name 'ssh9222'               
        list proto 'tcp'                    
        option src 'wan'                       
        option src_dport '9222'                 
        option dest_ip '172.16.1.1'           
        option dest_port '22'

EOF