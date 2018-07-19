#-------------------------------------------------
#
# Project created by QtCreator 2018-07-11T16:16:04
#
#-------------------------------------------------

QT  += core gui
QT  += quickwidgets
QT  += multimedia
QT  +=
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
    mainwindow.cpp \
    netapi.cpp \
    netrecommend.cpp \
    netsongdetails.cpp \
    netplaylistdetails.cpp \
    netlyrics.cpp \
    netsongurl.cpp \
    mainplayer.cpp \
    mylayout.cpp \
    closelabel.cpp \
    navigation.cpp

HEADERS += \
    mainwindow.h \
    netrecommend.h \
    netplaylistdetails.h \
    netlyrics.h \
    netsongdetails.h \
    cloudmusicapi.h \
    netsongurl.h \
    mainplayer.h \
    mylayout.h \
    closelabel.h \
    navigation.h

FORMS += \
    mainwindow.ui

DISTFILES += \
    recommend.qml \
    list.qml \
    mediaplayer.qml
