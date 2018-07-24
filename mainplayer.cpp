#include "mainplayer.h"
#include "cloudmusic/cloudmusicapi.h"
#include <QVariant>
#include <QMetaObject>
#include <QQuickItem>

MainPlayer::MainPlayer(QObject *parent,QQuickWidget *p) : QObject(parent)
{
    player=p;
}
void MainPlayer::addToList(QString id){
    // http://music.163.com/song/media/outer/url?id=
    playlist.push_back(id);
    QMetaObject::invokeMethod(player->rootObject(),"setListNum",Qt::DirectConnection,Q_ARG(QVariant,QVariant(playlist.size())));
    QMetaObject::invokeMethod(player->rootObject(),"addItem",Qt::DirectConnection,Q_ARG(QVariant,id));
}
void MainPlayer::newPlay(QString id){
    addToList(id); // 添加到数据库
    QVariant arg;
    arg.setValue(id);
    QQuickItem *p=player->rootObject();
    QMetaObject::invokeMethod(p,"newPlay",Qt::DirectConnection,Q_ARG(QVariant,arg)); // 添加到QML MediaPlayer　playlist
}
