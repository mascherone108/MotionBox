#!/bin/sh
set -e

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

Sky="../Sky"

external="../3rdparty"

#--------------------------------------------------------------------------------------------------

SSL_versionA="1.0.2p"
SSL_versionB="1.1.1d"

VLC_version="3.0.10"

#--------------------------------------------------------------------------------------------------
# Windows

MinGW_version="7.3.0"

#--------------------------------------------------------------------------------------------------
# Syntax
#--------------------------------------------------------------------------------------------------

if [ $# != 2 -a $# != 3 ] \
   || \
   [ $1 != "qt4" -a $1 != "qt5" -a $1 != "clean" ] \
   || \
   [ $2 != "win32" -a $2 != "win64" -a $2 != "win32-msvc" -a $2 != "win64-msvc" -a \
     $2 != "macOS" -a $2 != "linux" -a $2 != "android" ] \
   || \
   [ $# = 3 -a "$3" != "sky" ]; then

    echo "Usage: configure <qt4 | qt5 | clean>"
    echo "                 <win32 | win64 | win32-msvc | win64-msvc | macOS | linux | android>"
    echo "                 [sky]"

    exit 1
fi

#--------------------------------------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------------------------------------

external="$external/$2"

if [ $2 = "win32" -o $2 = "win64" -o $2 = "win32-msvc" -o $2 = "win64-msvc" ]; then

    os="windows"

    if [ $2 = "win32"  -o $2 = "win64" ]; then

        compiler="mingw"

        MinGW="$external/MinGW/$MinGW_version/bin"
    else
        compiler="default"
    fi
else
    os="default"

    compiler="default"
fi

#--------------------------------------------------------------------------------------------------

if [ $1 = "qt4" ]; then

    SSL="$external/OpenSSL/$SSL_versionA"
else
    SSL="$external/OpenSSL/$SSL_versionB"
fi

VLC="$external/VLC/$VLC_version"

#--------------------------------------------------------------------------------------------------
# Clean
#--------------------------------------------------------------------------------------------------

echo "CLEANING"

rm -rf lib
mkdir  lib
touch  lib/.gitignore

rm -rf bin/*
touch  bin/.gitignore

# NOTE: We have to remove the folder to delete .qmake.stash.
rm -rf build
mkdir  build
touch  build/.gitignore

if [ $1 = "clean" ]; then

    exit 0
fi

#--------------------------------------------------------------------------------------------------
# Sky
#--------------------------------------------------------------------------------------------------

if [ "$3" = "sky" ]; then

    echo "CONFIGURING Sky"
    echo "---------------"

    cd "$Sky"

    sh configure.sh $1 $2

    cd -

    echo "---------------"
    echo ""
fi

#--------------------------------------------------------------------------------------------------
# MinGW
#--------------------------------------------------------------------------------------------------

echo "CONFIGURING MotionBox"
echo "---------------------"

if [ $compiler = "mingw" ]; then

    cp "$MinGW"/libgcc_s_*-1.dll    bin
    cp "$MinGW"/libstdc++-6.dll     bin
    cp "$MinGW"/libwinpthread-1.dll bin
fi

#--------------------------------------------------------------------------------------------------
# SSL
#--------------------------------------------------------------------------------------------------

if [ $os = "windows" ]; then

    echo "COPYING SSL"

    cp "$SSL"/*.dll bin
fi

#--------------------------------------------------------------------------------------------------
# VLC
#--------------------------------------------------------------------------------------------------

if [ $os = "windows" ]; then

    echo "COPYING VLC"

    rm -rf bin/plugins
    mkdir  bin/plugins

    cp -r "$VLC"/plugins/access        bin/plugins
    cp -r "$VLC"/plugins/audio_filter  bin/plugins
    cp -r "$VLC"/plugins/audio_mixer   bin/plugins
    cp -r "$VLC"/plugins/audio_output  bin/plugins
    cp -r "$VLC"/plugins/codec         bin/plugins
    cp -r "$VLC"/plugins/control       bin/plugins
    cp -r "$VLC"/plugins/demux         bin/plugins
    cp -r "$VLC"/plugins/misc          bin/plugins
    cp -r "$VLC"/plugins/packetizer    bin/plugins
    cp -r "$VLC"/plugins/stream_filter bin/plugins
    cp -r "$VLC"/plugins/stream_out    bin/plugins
    cp -r "$VLC"/plugins/video_chroma  bin/plugins
    cp -r "$VLC"/plugins/video_filter  bin/plugins
    cp -r "$VLC"/plugins/video_output  bin/plugins

    cp "$VLC"/libvlc*.dll bin

elif [ $2 = "macOS" ]; then

    rm -rf bin/plugins
    mkdir  bin/plugins

    cp -r "$VLC"/plugins/*.dylib bin/plugins

    cp "$VLC"/lib/libvlc.5.dylib     bin/libvlc.dylib
    cp "$VLC"/lib/libvlccore.9.dylib bin/libvlccore.dylib
fi

echo "---------------------"
