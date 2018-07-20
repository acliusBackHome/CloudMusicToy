#-------------------------------------------------
#
# Project created by QtCreator 2018-07-11T16:16:04
#
#-------------------------------------------------

QT  += core gui quickwidgets multimedia # av
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = wyytoy
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += \
    main.cpp \
    mainplayer.cpp \
    closelabel.cpp \
    navigation.cpp \
    cloudmusic/netapi.cpp \
    cloudmusic/netcomment.cpp \
    cloudmusic/netlyrics.cpp \
    cloudmusic/netplaylistdetails.cpp \
    cloudmusic/netrecommend.cpp \
    cloudmusic/netsongdetails.cpp \
    cloudmusic/netsongurl.cpp \
    cloudmusic.cpp

HEADERS += \
    mainplayer.h \
    closelabel.h \
    navigation.h \
    cloudmusic/cloudmusicapi.h \
    cloudmusic/netapi.h \
    cloudmusic/netcomment.h \
    cloudmusic/netlyrics.h \
    cloudmusic/netplaylistdetails.h \
    cloudmusic/netrecommend.h \
    cloudmusic/netsongdetails.h \
    cloudmusic/netsongurl.h \
    cloudmusic.h

FORMS += \
    cloudmusic.ui

DISTFILES += \
    recommend.qml \
    list.qml \
    mediaplayer.qml

RESOURCES += \
    img.qrc
