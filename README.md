<a href="http://omega.gg/MotionBox"><img src="dist/icon.png" alt="MotionBox" width="128px"></a>
---
[![azure](https://dev.azure.com/bunjee/MotionBox/_apis/build/status/omega-gg.MotionBox)](https://dev.azure.com/bunjee/MotionBox/_build)
[![travis](http://api.travis-ci.org/omega-gg/MotionBox.svg)](http://travis-ci.org/omega-gg/MotionBox)
[![appveyor](http://ci.appveyor.com/api/projects/status/ct0kbo659jviskec?svg=true)](http://ci.appveyor.com/project/3unjee/motionbox)
[![GPLv3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl.html)

[MotionBox](http://omega.gg/MotionBox) is a video player designed for the Internet.<br>
Built to access and browse decentralized video sources.<br>
Built to load and play multiple video resources.<br>
[omega](http://omega.gg/about) is building MotionBox to empower people.<br>

## MotionBox Video Browser
<a href="http://omega.gg/MotionBox"><img src="dist/pictures/MotionBox.png" alt="Video Browser" width="512px"></a>

MotionBox accesses videos directly via [DuckDuckGo](http://en.wikipedia.org/wiki/DuckDuckGo).<br>
It streams [Torrents](http://en.wikipedia.org/wiki/BitTorrent), [Youtube](http://en.wikipedia.org/wiki/Youtube), [Dailymotion](http://en.wikipedia.org/wiki/Dailymotion), [Vimeo](http://en.wikipedia.org/wiki/Vimeo) and [SoundCloud](http://en.wikipedia.org/wiki/SoundCloud).<br>
All of this inside multiple tabs and without ever showing an ad.<br>

## For Motion Freedom

- Freedom to access video resources on the Internet.
- Freedom to browse decentralized video sources.
- Freedom to share video content with the world.

## Technology

MotionBox is built in C++ with [Sky kit](http://omega.gg/Sky/sources).<br>
Sky is built on the [Qt framework](http://github.com/qtproject).<br>
The GUI uses QML. The player uses [VLC](http://github.com/videolan/vlc) and [libtorrent](http://en.wikipedia.org/wiki/libtorrent).<br>

## Platforms

- Windows XP and later.
- macOS 64 bit.
- Linux 32 bit and 64 bit.
- Android 32 bit and 64 bit (experimental).

## Requirements

- [Sky](http://omega.gg/Sky/sources) latest version.
- [Qt](http://download.qt.io/official_releases/qt) 4.8.0 / 5.5.0 or later.
- [VLC](http://download.videolan.org/pub/videolan/vlc) 2.2.0 or later.
- [libtorrent](http://github.com/arvidn/libtorrent/releases) 1.1.0 or later.
- [Boost](http://www.boost.org/users/download) 1.55.0 or later.
- [OpenSSL](http://www.openssl.org/source) / [Win32OpenSSL](http://slproweb.com/products/Win32OpenSSL.html) 1.0.1 or later.

On Windows:
- [MinGW](http://sourceforge.net/projects/mingw) or [Git for Windows](http://git-for-windows.github.io) with g++ 4.9.2 or later.

Recommended:
- [Qt Creator](http://download.qt.io/official_releases/qtcreator) 3.6.0 or later.

## 3rdparty

You can install third party libraries with:

    sh 3rdparty.sh <win32 | win64 | macOS | linux | android>

## Configure

You can configure MotionBox with:

    sh configure.sh <qt4 | qt5 | clean> <win32 | win64 | macOS | linux | android> [sky]

## Build

You can build MotionBox with Qt Creator:
- Open [MotionBox.pro](MotionBox.pro).
- Click on "Build > Build all".

Or the build script:

    sh build.sh <qt4 | qt5 | clean> <win32 | win64 | macOS | linux | android> [deploy]

Or the console:

    qmake -r
    make (mingw32-make on Windows)

## Deploy

1\. Generate the qrc file:

    cd dist
    sh generate.sh <qt4 | qt5 | clean> <win32 | win64 | macOS | linux | android> [deploy]

2\. Build MotionBox:

    qmake -r "DEFINES += SK_DEPLOY" "RESOURCES = dist/MotionBox.qrc"
    make (mingw32-make on Windows)

3\. Deploy MotionBox:

    sh deploy.sh <qt4 | qt5 | clean> <win32 | win64 | macOS | linux | android>

## License

Copyright (C) 2015 - 2020 MotionBox authors united with [omega](http://omega.gg/about).

### Authors

- Benjamin Arnaud aka [bunjee](http://bunjee.me) | <bunjee@omega.gg>

### GNU General Public License Usage

MotionBox may be used under the terms of the GNU General Public License version 3 as published
by the Free Software Foundation and appearing in the LICENSE.md file included in the packaging
of this file. Please review the following information to ensure the GNU General Public License
requirements will be met: https://www.gnu.org/licenses/gpl.html.
