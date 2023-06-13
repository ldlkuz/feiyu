#!/bin/bash
echo "----------------------------------------------"
echo "+ 说明：第一次使用选择T,会解除分区限制，然后 +"
echo "+ 在运行，选择Y，并且永久打开无线调试，然后  +"
echo "+ 车机会重启，以后就可以wifi调试了，之后每次 +"
echo "+ 使用就选择N就行了，前面两次是准备工作      +"
echo "----------------------------------------------"
echo "\033[33m请选择操作：\033[0m"
echo "\033[34mY. 是否第一次使用\033[0m"
echo "\033[34mN. 直接开始破解车机\033[0m"
echo "\033[34mT. 第一次使用前选择T解除分区限制\033[0m"
# 读取用户输入
read -p "$(LANG=C echo '\033[33m按请输入选项：\033[0m')" choice
choice=$(echo $choice | tr '[:lower:]' '[:upper:]')
case $choice in
    "Y")
        if grep -q "tuna" $PREFIX/etc/apt/sources.list.d/* 2>/dev/null; then
          echo "\033[31m已经是清华源，无需更换\033[0m"
        else
          echo "\033[33m更换清华源\033[0m"
          echo "deb https://mirrors.tuna.tsinghua.edu.cn/termux stable main" > $PREFIX/etc/apt/sources.list.d/tuna.list
          pkg update -y && pkg upgrade -y
        fi
        # 安装Android-tools
        if command -v adb >/dev/null 2>&1; then
          echo "\033[31mAndroid-tools已安装，无需安装\033[0m"
        else
          echo "\033[33m安装Android-tools\033[0m"
          # 安装Android-tools
          pkg install -y android-tools
        fi
        # 申请挂载本地存储
        termux-setup-storage
        # 开启WiFi调试选项
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
        adb connect $ip
        if [ $? -ne 0 ]; then
            echo "\033[31m连接失败请重新连接\033[0m"
            read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
            clear
            break
        fi
        adb root
        if [ $? -ne 0 ]; then
            echo "\033[31madb root失败请重新连接\033[0m"
            read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
            clear
            break
        fi
        adb remount
        if [ $? -ne 0 ]; then
            echo "\033[31madb root失败请重新连接\033[0m"
            read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
            clear
            break
        fi
        echo "adb36987" | adb shell setprop persist.adb.tcp.port 5555
        echo "adb36987" | adb shell setprop service.adb.tcp.port 5656[Lonbon]
        read -p "$(LANG=C echo '\033[32m操作成功，按回车键重启车机\033[0m')" key
        adb reboot
        clear
        ;;
    "N")
        sh reaton.sh
        clear
        ;;
    "T")
        if grep -q "tuna" $PREFIX/etc/apt/sources.list.d/* 2>/dev/null; then
          echo "\033[31m已经是清华源，无需更换\033[0m"
        else
          echo "\033[33m更换清华源\033[0m"
          echo "deb https://mirrors.tuna.tsinghua.edu.cn/termux stable main" > $PREFIX/etc/apt/sources.list.d/tuna.list
          pkg update -y && pkg upgrade -y
        fi
        # 安装Android-tools
        if command -v adb >/dev/null 2>&1; then
          echo "\033[31mAndroid-tools已安装，无需安装\033[0m"
        else
          echo "\033[33m安装Android-tools\033[0m"
          # 安装Android-tools
          pkg install -y android-tools
        fi
        # 申请挂载本地存储
        termux-setup-storage
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
        echo "\033[33m解除分区限制\033[0m"
        adb connect $ip
        if [ $? -ne 0 ]; then
            echo "\033[31m连接失败请重新连接\033[0m"
            read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
            clear
            break
        fi
        adb root
        if [ $? -ne 0 ]; then
            echo "\033[31madb root失败请重新连接\033[0m"
            read -p "$(LANG=C echo '\033[31m按回车键重新连接车机\033[0m')" key
            clear
            break
        fi
        adb disable-verity
        read -p "$(LANG=C echo '\033[32m操作成功，按回车键重启车机后再次运行脚本\033[0m')" key
        adb reboot
        clear
        ;;
    *) 
        echo "\033[34m无效选择自动退出\033[0m"
        exit
        ;;
esac        
break