#!/bin/bash
while true; do
    echo "----------------------------------------------"
    echo " 锐程plus专用工具v1.9---作者：树sir             "
    echo " 参考思路：by--夕阳下午睡的猫                   "
    echo "----------------------------------------------"
    echo "        | adb工具命令选项 | "
    echo "---------------------------"
    echo "★ 1.WiFi连接车机   （车机重启后需要进行重连adb）"
    echo "----------------------------------------------"
    echo "★ 2.备份系统app    （备份到sdcard/changan/bak）"
    echo "----------------------------------------------"
    echo "★ 3.解除分区限制   （第一次连接车机使用一次就行）"
    echo "----------------------------------------------"
    echo "★ 4.解除第三方限制 （删除decore，安装第三方必做）"
    echo "----------------------------------------------"
    echo "★ 5.卸载自带高德地图"
    echo "----------------------------------------------"
    echo "★ 6.更新高德地图   （安装前需卸载自带高德）"
    echo "----------------------------------------------"
    echo "★ 7.安装第三方     （lib提取安装）"
    echo "----------------------------------------------"
    echo "★ 8.卸载第三方     （lib安装创建的文件夹名称）"
    echo "----------------------------------------------"
    echo "★ 9.恢复第三方限制 （还原decore）"
    echo "----------------------------------------------"
    echo "★ a.查看system/app可用空间"
    echo "----------------------------------------------"
    echo "★ b.查看system/app下文件系统"
    echo "----------------------------------------------"
    echo "★ c.禁用/启用 车机升级"
    echo "----------------------------------------------"
    echo "★ d.单独推apk到system/app"
    echo "----------------------------------------------"
    echo "★ 0.退出"
    echo "----------------------------------------------"
    read -p read -p "$(LANG=C echo '\033[33m请输入选项：\033[0m')" main
    case $main in
        1)
            while true
            do
                read -p "$(LANG=C echo '\033[33m请输入IP地址和端口：\033[0m')" ip
                adb connect $ip
                result=$(adb devices | grep $ip)
                if [ $? -eq 0 ] && [ "$result" != "" ]; then
                    echo "\033[32madb已连接\033[0m"
                    read -p "$(LANG=C echo '\033[32m连接成功，按回车键开始破解车机\033[0m')" key
                    clear
                    break
                else
                    echo "\033[31连接失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                fi
            done
        ;;
        2)
            while true
            do
                clear
                adb connect $ip
                if [ $? -ne 0 ]; then
                    echo "\033[31m连接失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb root
                if [ $? -ne 0 ]; then
                    echo "\033[31madb root失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb remount
                if [ $? -ne 0 ]; then
                    echo "\033[31madb root失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                result=$(adb devices | grep $ip)
                if [ $? -eq 0 ] && [ "$result" != "" ]; then
                    echo "\033[34m开始备份车机软件到bak目录\033[0m"
                    adb pull /system/app /sdcard/changan/bak
                    sleep 1
                    adb pull /system/priv-app /sdcard/changan/bak/priv-app
                    echo "\033[32m备份完成\033[0m"
                    read -p "$(LANG=C echo '\033[34m按回车键返回菜单\033[0m')" key
                    clear
                    break
                else
                    echo "\033[31m连接失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
            done
        ;;
        3)
            while true
            do
                clear
                adb connect $ip
                if [ $? -ne 0 ]; then
                    echo "\033[31m连接失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb root
                if [ $? -ne 0 ]; then
                    echo "\033[31madb root失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                result=$(adb devices | grep $ip)
                if [ $? -eq 0 ] && [ "$result" != "" ]; then
                    echo "\033[34m解除分区限制----\033[0m"
                    adb disable-verity
                    read -p "$(LANG=C echo '\033[32m解除分区限制完成，按回车重启车机\033[0m')" key
                    adb reboot
                    clear
                    break
                else
                    echo "\033[31m请确认adb已连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    break
                fi
            done
        ;;
        4) 
            while true
            do
                clear
                adb connect $ip
                if [ $? -ne 0 ]; then
                    echo "\033[31m连接失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb root
                if [ $? -ne 0 ]; then
                    echo "\033[31madb root失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb remount
                if [ $? -ne 0 ]; then
                    echo "\033[31madb remount失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                result=$(adb devices | grep $ip)
                if [ $? -eq 0 ] && [ "$result" != "" ]; then
                    echo "\033[34m解除第三方限制----\033[0m"
                    echo "adb36987" | adb shell rm -f  /system/app/VecentekApp/VecentekApp.apk
                    read -p "$(LANG=C echo '\033[32m解除第三方限制完成，按回车重启车机\033[0m')" key
                    adb reboot
                    clear
                    break
                else
                    echo "\033[31m请确认adb已连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
            done
        ;;
        5) 
            while true
            do
                clear
                adb connect $ip
                if [ $? -ne 0 ]; then
                    echo "\033[31m连接失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb root
                if [ $? -ne 0 ]; then
                    echo "\033[31madb root失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb remount
                if [ $? -ne 0 ]; then
                    echo "\033[31madb remount失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi          
                result=$(adb devices | grep $ip)
                if [ $? -eq 0 ] && [ "$result" != "" ]; then
                    echo "\033[34m卸载高德地图----\033[0m"
                    echo "adb36987" | adb shell rm -rf /system/app/AutoNavi
                    read -p "$(LANG=C echo '\033[32m按回车键重启车机\033[0m')" key
                    adb reboot
                    clear
                    break
                else
                    echo "\033[31m请确认adb已连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
            done
        ;;
        6)
            while true
            do
                clear
                adb connect $ip
                if [ $? -ne 0 ]; then
                    echo "\033[31m连接失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb root
                if [ $? -ne 0 ]; then
                    echo "\033[31madb root失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb remount
                if [ $? -ne 0 ]; then
                    echo "\033[31madb remount失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                result=$(adb devices | grep $ip)
                if [ $? -eq 0 ] && [ "$result" != "" ]; then
                    echo "\033[34m更新高德地图----\033[0m"
                    echo "adb36987" | adb shell mkdir /system/app/AutoNavi
                    echo "adb36987" | adb shell mkdir /data/gaodetmp
                    adb push /sdcard/changan/AutoNavi/lib.tar.gz /data/gaodetmp
                    echo "adb36987" | adb shell "cd /data/gaodetmp && tar -zxvf lib.tar.gz && mv lib /system/app/AutoNavi"
                    adb push /sdcard/changan/AutoNavi/AutoNavi.apk /system/app/AutoNavi
                    rm -rf /data/gaodetmp
                    read -p "$(LANG=C echo '\033[32m按回车键重启车机\033[0m')" key
                    adb reboot
                    clear
                    break
                else
                    echo "\033[31m请确认adb已连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
            done
        ;;     
        7)
            while true
            do
                clear
                adb connect $ip
                if [ $? -ne 0 ]; then
                    echo "\033[31m连接失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb root
                if [ $? -ne 0 ]; then
                    echo "\033[31madb root失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb remount
                if [ $? -ne 0 ]; then
                    echo "\033[31madb remount失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi         
                result=$(adb devices | grep $ip)
                if [ $? -eq 0 ] && [ "$result" != "" ]; then
                    # 读取用户输入的文件夹名称
                    read -p "$(LANG=C echo '\033[33m请输入文件夹名称：\033[0m')" folder_name
                    # 创建指定文件夹
                    echo "adb36987" | adb shell mkdir /system/app/$folder_name
                    # 读取用户输入的apk文件名
                    read -p "$(LANG=C echo '\033[33m请输入apk文件全称：\033[0m')" apk_name
                    # 创建tmp目录
                    mkdir /sdcard/changan/tmp
                    # 创建backlib目录，备份解压后的lib
                    mkdir /sdcard/changan/tmp/backlib
                    mkdir /sdcard/changan/tmp/backlib/lib
                    # 创建其他软件lib预存目录
                    echo "adb36987" | adb shell mkdir /data/libtmp
                    # 解压指定的apk到tmp目录
                    unzip -o /sdcard/changan/$apk_name -d /sdcard/changan/tmp
                    # 检查lib目录下的结构，并重命名
                    if [ -d "/sdcard/changan/tmp/lib/arm64-v8a" ]; then
                        mv /sdcard/changan/tmp/lib/arm64-v8a /sdcard/changan/tmp/backlib/lib/arm64
                    fi 
                    if [ -d "/sdcard/changan/tmp/lib/armeabi-v7a" ]; then
                        mv /sdcard/changan/tmp/lib/armeabi-v7a /sdcard/changan/tmp/backlib/lib/arm
                    fi 
                    if [ -d "/sdcard/changan/tmp/lib/armeabi" ]; then
                        mv /sdcard/changan/tmp/lib/armeabi /sdcard/changan/tmp/backlib/lib/arm
                    fi
                    # 将解压后的lib压缩tar.gz格式
                    cd /sdcard/changan/tmp/backlib && tar -zcvf lib.tar.gz lib
                    # 将tmp目录下的lib.tar.gz文件夹推送到指定目录下
                    sleep 1
                    adb push /sdcard/changan/tmp/backlib/lib.tar.gz /data/libtmp
                    # 解压lib.tar.gz文件
                    echo "adb36987" | adb shell "cd /data/libtmp && tar -zxvf lib.tar.gz"
                    # 推送lib文件夹
                    sleep 1
                    echo "adb36987" | adb shell mv /data/libtmp/lib /system/app/$folder_name
                    # 删除libtar.gz文件
                    echo "adb36987" | adb shell rm -rf /data/libtmp/lib.tar.gz
                    # 上传指定的apk文件到/system/app目录下
                    adb push /sdcard/changan/$apk_name /system/app/
                    # 等待6秒
                    sleep 6
                    # 将apk移动到指定文件夹下
                    echo "adb36987" | adb shell mv /system/app/$apk_name /system/app/$folder_name
                    read -p "$(LANG=C echo '\033[32m安装完成，按回车键重启车机\033[0m')" key
                    # 清空tmp文件夹
                    rm -rf /sdcard/changan/tmp
                    adb reboot
                    clear
                    break
                else
                    echo "\033[31m请确认adb已连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
            done     
        ;;
        8) 
            while true
            do
                clear
                adb connect $ip
                if [ $? -ne 0 ]; then
                    echo "\033[31m连接失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb root
                if [ $? -ne 0 ]; then
                    echo "\033[31madb root失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb remount
                if [ $? -ne 0 ]; then
                    echo "\033[31madb remount失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi         
                result=$(adb devices | grep $ip)
                if [ $? -eq 0 ] && [ "$result" != "" ]; then
                    echo "\033[34m删除第三方软件----\033[0m"
                    while true
                    do
                        read -p "$(LANG=C echo '\033[33m请输入创建的文件夹名称：\033[0m')" folder_nameother
                        if [ -z "$folder_nameother" ]; then
                            echo "\033[31m输入不能为空，请重新输入\033[0m"
                        elif echo "$folder_nameother" | grep -q '[[:space:]]'; then
                            echo "\033[31m输入不能包含空格，请重新输入\033[0m"
                        else
                            break
                        fi
                    done
                    echo "adb36987" | adb shell rm -rf  /system/app/$folder_nameother
                    read -p "$(LANG=C echo '\033[31m按回车键重启车机\033[0m')" key
                    adb reboot
                    clear
                    break
                else
                    echo "\033[31m请确认adb已连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
            done
        ;;
        9) 
            while true
            do
                clear
                adb connect $ip
                if [ $? -ne 0 ]; then
                    echo "\033[31m连接失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb root
                if [ $? -ne 0 ]; then
                    echo "\033[31madb root失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb remount
                if [ $? -ne 0 ]; then
                    echo "\033[31madb remount失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                result=$(adb devices | grep $ip)
                if [ $? -eq 0 ] && [ "$result" != "" ]; then
                    echo "\033[34m恢复第三方限制----\033[0m"
                    adb push /sdcard/changan/VecentekApp.apk /system/app/VecentekApp
                    read -p "$(LANG=C echo '\033[32m恢复成功，按回车键重启车机\033[0m')" key
                    adb reboot
                    clear
                    break
                else
                    echo "\033[31m请确认adb已连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi 
            done  
        ;;
        a) 
            while true
            do
                clear
                adb connect $ip
                if [ $? -ne 0 ]; then
                    echo "\033[31m连接失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb root
                if [ $? -ne 0 ]; then
                    echo "\033[31madb root失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb remount
                if [ $? -ne 0 ]; then
                    echo "\033[31madb remount失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                result=$(adb devices | grep $ip)
                if [ $? -eq 0 ] && [ "$result" != "" ]; then
                    echo "\033[34m---查看system可用空间----\033[0m"
                    echo "adb36987" | adb shell df -h /system/app
                    read -p "$(LANG=C echo '\033[33m按回车键返回菜单\033[0m')" key
                    clear
                    break
                else
                    echo "\033[31m请确认adb已连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m未查询到，按回车键返回菜单\033[0m')" key
                    clear
                    break
                fi
            done
        ;;
        b)
            while true
            do
                clear
                adb connect $ip
                if [ $? -ne 0 ]; then
                    echo "\033[31m连接失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb root
                if [ $? -ne 0 ]; then
                    echo "\033[31madb root失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb remount
                if [ $? -ne 0 ]; then
                    echo "\033[31madb remount失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                result=$(adb devices | grep $ip)
                if [ $? -eq 0 ] && [ "$result" != "" ]; then
                    echo "\033[33m---查看app安装情况----\033[0m"
                    echo "adb36987" | adb shell pm list packages
                    read -p "$(LANG=C echo '\033[33m按回车键查看app目录文件\033[0m')" key
                    echo "adb36987" | adb shell ls /system/app
                    read -p "$(LANG=C echo '\033[33m按回车键返回菜单\033[0m')" key
                    clear
                    break
                else
                    echo "\033[31m请确认adb已连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m未查询到，按回车键返回菜单\033[0m')" key
                    clear
                    break
                fi
            done
        ;;
        c)
            while true
            do
                clear
                adb connect $ip
                if [ $? -ne 0 ]; then
                    echo "\033[31m连接失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb root
                if [ $? -ne 0 ]; then
                    echo "\033[31madb root失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                sleep 1
                adb remount
                if [ $? -ne 0 ]; then
                    echo "\033[31madb remount失败请重新连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi
                result=$(adb devices | grep $ip)
                if [ $? -eq 0 ] && [ "$result" != "" ]; then
                    # 显示菜单
                    echo "\033[33m请选择操作：\033[0m"
                    echo "\033[34mN. 禁用车机升级\033[0m"
                    echo "\033[34mY. 启用车机升级\033[0m"
                    # 读取用户输入
                    read -p "$(LANG=C echo '\033[33m按请输入选项：\033[0m')" choice
                    choice=$(echo $choice | tr '[:lower:]' '[:upper:]')
                    case $choice in
                        "N")
                           echo "adb36987" | adb shell mv /system/app/IncallFota/IncallFota.apk /system/app/IncallFota/IncallFota.bak
                           ;;
                        "Y")
                           echo "adb36987" | adb shell mv /system/app/IncallFota/IncallFota.bak /system/app/IncallFota/IncallFota.apk
                           ;;
                        *)
                           echo "\033[34m无效选择\033[0m"
                           ;;
                    esac        
                    read -p "$(LANG=C echo '\033[32m操作成功，按回车键重启车机\033[0m')" key
                    adb reboot
                    clear
                    break
                else
                    echo "\033[31m请确认adb已连接\033[0m"
                    read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                    clear
                    break
                fi 
            done
        ;;
        d)
            while true
                do
                    clear
                    adb connect $ip
                    if [ $? -ne 0 ]; then
                        echo "\033[31m连接失败请重新连接\033[0m"
                        read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                        clear
                        break
                    fi
                    sleep 1
                    adb root
                    if [ $? -ne 0 ]; then
                        echo "\033[31madb root失败请重新连接\033[0m"
                        read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                        clear
                        break
                    fi
                    sleep 1
                    adb remount
                    if [ $? -ne 0 ]; then
                        echo "\033[31madb remount失败请重新连接\033[0m"
                        read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                        clear
                        break
                    fi
                    result=$(adb devices | grep $ip)
                    if [ $? -eq 0 ] && [ "$result" != "" ]; then
                        read -p "$(LANG=C echo '\033[33m请输入apk文件全称：\033[0m')" apk_mingcheng
                        # 上传指定的apk文件到/system/app目录下
                        adb push /sdcard/changan/$apk_mingcheng /system/app/
                        read -p "$(LANG=C echo '\033[32m上传成功，按回车键重启车机\033[0m')" key
                        adb reboot
                        clear
                        break
                    else
                        echo "\033[31m请确认adb已连接\033[0m"
                        read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
                        clear
                        break
                    fi 
                done  
        ;;
        *) exit;;
    esac
done