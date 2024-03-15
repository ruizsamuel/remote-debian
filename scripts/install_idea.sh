#!/bin/bash

ARCH=$(dpkg --print-architecture)

if [ "$ARCH" = "arm64" ]; then
    wget https://download.jetbrains.com/idea/ideaIC-2023.2.5-aarch64.tar.gz
    tar -xf ideaIC-2023.2.5-aarch64.tar.gz -C /usr/share/
    rm ideaIC-2023.2.5-aarch64.tar.gz
    ln -s /usr/share/idea-IC-232.10227.8/bin/idea.sh /bin/idea
else
    curl -s https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | apt-key add -
    echo "deb http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com bionic main" | tee /etc/apt/sources.list.d/jetbrains-ppa.list > /dev/null
    apt update
    apt install intellij-idea-community
fi
