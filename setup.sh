#!/bin/bash

echo "我就想简单配置一下我的镜像/(ㄒoㄒ)/~~"
echo ""
echo "请选择要执行的操作："
echo "1) 更改系统更新镜像"
echo "2) 更改 docker 镜像"
echo "3) 更改 go 镜像"
echo "4) 更改 python 镜像"
echo ""
read -p "请输入选项 [1-4]: " choice < /dev/tty

case $choice in
    1)
        echo "正在更改系统更新镜像..."
        echo ""
        echo "请选择发行版："
        echo "1) Debian"
        echo "2) Ubuntu"
        echo ""
        read -p "请输入选项 [1-2]: " distro_choice < /dev/tty

        case $distro_choice in
            1)
                echo "正在配置 Debian 镜像源..."
                echo "注意：当前配置为 Debian 13 (trixie)"
                read -n 1 -s -r -p "按任意键继续...Ctrl+C 取消" < /dev/tty

                # 第1步：备份原文件
                sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

                # 第2步：写入 HTTP 源
                sudo tee /etc/apt/sources.list > /dev/null << 'EOF'
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ trixie main contrib non-free non-free-firmware
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ trixie main contrib non-free non-free-firmware

deb http://mirrors.tuna.tsinghua.edu.cn/debian/ trixie-updates main contrib non-free non-free-firmware
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ trixie-updates main contrib non-free non-free-firmware

deb http://mirrors.tuna.tsinghua.edu.cn/debian/ trixie-backports main contrib non-free non-free-firmware
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ trixie-backports main contrib non-free non-free-firmware

# 以下安全更新软件源为镜像站配置
deb http://mirrors.tuna.tsinghua.edu.cn/debian-security trixie-security main contrib non-free non-free-firmware
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian-security trixie-security main contrib non-free non-free-firmware

EOF

                # 第3步：安装 HTTPS 依赖
                sudo apt install apt-transport-https ca-certificates

                # 第4步：写入 HTTPS 源
                sudo tee /etc/apt/sources.list > /dev/null << 'EOF'
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ trixie main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ trixie main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ trixie-updates main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ trixie-updates main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ trixie-backports main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ trixie-backports main contrib non-free non-free-firmware

# 以下安全更新软件源为镜像站配置
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security trixie-security main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security trixie-security main contrib non-free non-free-firmware

EOF

                # 第5步：更新软件包列表
                sudo apt update

                echo "Debian 镜像源已更改为清华源 (HTTPS)"
                ;;
            2)
                echo "正在配置 Ubuntu 镜像源..."
                echo "注意：当前配置为 Ubuntu 26.04 LTS"
                read -n 1 -s -r -p "按任意键继续...Ctrl+C 取消" < /dev/tty

                # 第1步：备份原文件
                sudo cp /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.bak

                # 第2步：写入清华源
                sudo tee /etc/apt/sources.list.d/ubuntu.sources > /dev/null << 'EOF'
Types: deb
URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
Suites: resolute resolute-updates resolute-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
# Types: deb-src
# URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
# Suites: resolute resolute-updates resolute-backports
# Components: main restricted universe multiverse
# Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 以下安全更新软件源为镜像站配置
Types: deb
URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
Suites: resolute-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# Types: deb-src
# URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
# Suites: resolute-security
# Components: main restricted universe multiverse
# Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 预发布软件源，不建议启用

# Types: deb
# URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
# Suites: resolute-proposed
# Components: main restricted universe multiverse
# Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# # Types: deb-src
# # URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
# # Suites: resolute-proposed
# # Components: main restricted universe multiverse
# # Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOF

                # 第3步：更新软件包列表
                sudo apt update

                echo "Ubuntu 镜像源已更改为清华源"
                ;;
            *)
                echo "无效选项"
                exit 1
                ;;
        esac
        ;;
    2)
        echo "正在更改 docker 镜像..."
        ;;
    3)
        echo "正在更改 go 镜像..."
        ;;
    4)
        echo "正在更改 python 镜像..."
        ;;
    *)
        echo "无效选项"
        exit 1
        ;;
esac
