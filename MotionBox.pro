SK = $$_PRO_FILE_PWD_/../Sky

SK_CORE    = $$SK/src/SkCore/src
SK_GUI     = $$SK/src/SkGui/src
SK_MEDIA   = $$SK/src/SkMedia/src
SK_TORRENT = $$SK/src/SkTorrent/src
SK_BACKEND = $$SK/src/SkBackend/src

TARGET = MotionBox

contains(QT_MAJOR_VERSION, 4) {
    DESTDIR = $$_PRO_FILE_PWD_/bin
} else {
    DESTDIR = $$_PRO_FILE_PWD_/latest
}

contains(QT_MAJOR_VERSION, 4) {
    QT += opengl declarative network script xml xmlpatterns svg
} else {
    QT += opengl quick widgets network xml xmlpatterns svg
}

contains(QT_MAJOR_VERSION, 5) {
    win32:QT += winextras

    unix:QT += x11extras
}

macx: CONFIG -= app_bundle

DEFINES += CAN_COMPILE_SSE2 QUAZIP_BUILD \
           SK_CORE_LIBRARY SK_GUI_LIBRARY SK_MEDIA_LIBRARY SK_TORRENT_LIBRARY SK_BACKEND_LIBRARY

contains(QT_MAJOR_VERSION, 4) {
    DEFINES += QT_4

    CONFIG(release, debug|release) {

        win32:DEFINES += SK_WIN_NATIVE
    }
} else {
    DEFINES += QT_LATEST #SK_SOFTWARE

    win32:DEFINES += SK_WIN_NATIVE

    greaterThan(QT_MINOR_VERSION, 9): DEFINES += QT_5_LATEST
}

QMAKE_CXXFLAGS += -std=c++11 -msse

unix:QMAKE_LFLAGS += "-Wl,-rpath,'\$$ORIGIN'"

include(src/global/global.pri)
include(src/controllers/controllers.pri)
include(src/kernel/kernel.pri)
include(src/io/io.pri)
include(src/thread/thread.pri)
include(src/network/network.pri)
include(src/plugin/plugin.pri)
include(src/image/image.pri)
include(src/graphicsview/graphicsview.pri)
include(src/declarative/declarative.pri)
include(src/models/models.pri)
include(src/media/media.pri)
include(src/vlc/vlc.pri)
include(src/torrent/torrent.pri)

include(src/3rdparty/qtsingleapplication/qtsingleapplication.pri)
include(src/3rdparty/quazip/quazip.pri)

INCLUDEPATH += $$SK_CORE/../3rdparty/qtsingleapplication \
               $$SK_CORE/../3rdparty/quazip \
               $$SK/include/SkCore \
               $$SK/include/SkGui \
               $$SK/include/SkMedia \
               $$SK/include/SkTorrent \
               $$SK/include/SkBackend \
               $$SK/include \
               src/controllers \
               src/io \

contains(QT_MAJOR_VERSION, 5) {
    INCLUDEPATH += include/Qt5 \
                   include/Qt5/QtCore \
                   include/Qt5/QtGui \
                   include/Qt5/QtQml \
                   include/Qt5/QtQuick
}

unix:contains(QT_MAJOR_VERSION, 4) {
    INCLUDEPATH += include/Qt4/QtCore \
                   include/Qt4/QtGui \
                   include/Qt4/QtDeclarative
}

contains(QT_MAJOR_VERSION, 5):win32 {
    LIBS += -lopengl32
}

win32:LIBS += -L$$PWD/lib -lz \
              -L$$PWD/lib -llibvlc \
              -L$$PWD/lib -ltorrent \
              -L$$PWD/lib -lboost_system \
              -L$$PWD/lib -lboost_random \
              -L$$PWD/lib -lboost_chrono \
              -lmswsock -lws2_32 \

unix:LIBS += -lvlc \
             -ltorrent-rasterbar \
             -lboost_system -lboost_random -lboost_chrono \

RC_FILE = dist/MotionBox.rc

RESOURCES = dist/MotionBox.qrc

OTHER_FILES += configure.sh \
               build.sh \
               deploy.sh \
               README.md \
               LICENSE.md \
               AUTHORS.md \
               .travis.yml \
               .appveyor.yml \
               content/text/credits.txt \
               content/Main.qml \
               content/StyleApplication.qml \
               content/Splash.qml \
               content/Gui.qml \
               content/AreaContextualApplication.qml \
               content/AreaDrag.qml \
               content/ItemNew.qml \
               content/ItemTabMini.qml \
               content/TextLogo.qml \
               content/PanelApplication.qml \
               content/PanelDiscover.qml \
               content/PanelSearch.qml \
               content/PanelLibrary.qml \
               content/PanelFolder.qml \
               content/PanelTracks.qml \
               content/PanelPlayer.qml \
               content/PanelBrowse.qml \
               content/PanelRelated.qml \
               content/PanelCover.qml \
               content/PanelSettings.qml \
               content/PanelGet.qml \
               content/PanelAdd.qml \
               content/PanelPreview.qml \
               content/BarWindowApplication.qml \
               content/BarTop.qml \
               content/BarControls.qml \
               content/ButtonPianoTitle.qml \
               content/ButtonLogo.qml \
               content/ButtonsBrowse.qml \
               content/LineEditSearch.qml \
               content/ListFolder.qml \
               content/ListPlaylist.qml \
               content/ScrollFolder.qml \
               content/ScrollFolderCreate.qml \
               content/ScrollPlaylist.qml \
               content/ScrollPlaylistCreate.qml \
               content/ComponentDiscover.qml \
               content/ComponentLibraryItem.qml \
               content/ComponentTrack.qml \
               content/ComponentFolder.qml \
               content/BasePageSettings.qml \
               content/PageSettings.qml \
               content/PageSettingsMain.qml \
               content/PageSettingsProxy.qml \
               content/PageSettingsTorrent.qml \
               content/PageAbout.qml \
               content/PageAboutMain.qml \
               content/PageAboutText.qml \
               content/PageAboutMessage.qml \
               content/PageAboutCredits.qml \
               content/PageSubtitles.qml \
               content/PageSubtitlesSearch.qml \
               dist/MotionBox.rc \
               dist/qrc.sh \
               dist/doc/readme.md \
               dist/doc/shortcuts.md \
               dist/doc/about.md \
               dist/doc/license.md \
               dist/doc/fr/readme.md \
               dist/doc/fr/shortcuts.md \
               dist/doc/fr/about.md \
               dist/changes/1.0.1.md \
               dist/changes/1.1.0.md \
               dist/changes/1.1.1.md \
               dist/changes/1.1.2.md \
               dist/changes/1.2.0.md \
               dist/changes/1.3.0.md \
               dist/changes/1.4.0.md \
               dist/changes/1.5.0.md \
               dist/changes/1.5.1.md \
               dist/installer/config/config-win32.xml \
               dist/installer/config/config-win64.xml \
               dist/installer/config/controller.qs \
               dist/installer/packages/setup/meta/package.xml \
               dist/installer/packages/setup/meta/component.qs \
               dist/installer/packages/setup/meta/form.ui \
               dist/installer/packages/setup/data/setup.xml \
               dist/installer/packages/MotionBox/meta/package.xml \
               dist/installer/packages/Sky/meta/package.xml \
               dist/installer/packages/Qt/meta/package.xml \
               dist/installer/packages/VLC/meta/package.xml \
