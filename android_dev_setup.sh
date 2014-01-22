#!/bin/bash

#TODO
# 1. install JAVA if java not found
# 2. add option to install android anywhere
# 3. add option to uninstall android

# Colors
red='\e[0;33m'
green='\e[0;32m'
nc='\e[0m'

# Installs Android SDK and sets environment variables
# for development in emacs.
DROID_SDK_ROOT=~/android-sdk-linux
TMP=/tmp/android-sdk-linux
mkdir $TMP

if [ ! -d $DROID_SDK_ROOT ]; then
    DROID_SDK_URL=`
        curl -s https://developer.android.com/sdk/index.html#ExistingIDE | 
        grep 'id="linux-tools"' |
        sed 's/.*href="\([^"]*\)".*$/\1/'`
# courtesy of http://sed.sourceforge.net/grabbag/scripts/list_urls.sed
    sudo apt-get install ant

# install gradle
    GRADLE_SETUP_URL=`
        curl -s http://www.gradle.org/downloads |
        grep "binaries, sources and documentation" |
        sed 's/.*href="\([^"]*\)".*$/\1/'`
    wget $GRADLE_SETUP_URL
    sudo unzip -q gradle-1.0-bin.zip -d /usr/local/
    echo "export GRADLE_HOME=/usr/local/gradle-1.0" >> .profile
    echo "export PATH=$PATH:$GRADLE_HOME/bin" >> .profile

    cd $TMP
    wget $DROID_SDK_URL --output-document=android-sdk.tgz
    tar -xvzf android-sdk.tgz
    mv android-sdk-linux $HOME
    cd $HOME
fi

DROID_SDK_PATH=`grep android-sdk-linux ~/.bashrc_custom`
if [ -z "$DROID_SDK_PATH" ]; then
    echo nigga
    echo $SDK_PATH
    cat >> $HOME/.bashrc_custom <<EOF

# Android tools

export PATH=\$PATH:$DROID_SDK_ROOT/tools
export PATH=\$PATH:$DROID_SDK_ROOT/platform-tools
EOF

fi

if [ ! -f ~/.emacs.d/android-mode.el ]; then
    wget https://raw.github.com/cmeon/android-mode/master/android-mode.el
    mv android-mode.el ~/.emacs.d
fi

android
echo "Make sure JAVA_HOME path is set correctly directed to"
echo "where you installed emacs"
echo
echo -e "${green}Kwisha Kazi."
