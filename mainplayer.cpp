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
    playlist.push_back(id);
    QMetaObject::invokeMethod((QQuickItem *)(player->rootObject()),"setListNum",Qt::DirectConnection,Q_ARG(QVariant,QVariant(playlist.size())));
}
void MainPlayer::newPlay(QString id){
    addToList(id);
    NetSongUrl *k=new NetSongUrl(id,[&](QVariant res){
        qDebug()<<res<<endl;
        QVariant retValue;
        QQuickItem *p=player->rootObject();
        QMetaObject::invokeMethod(p,"newPlay",Qt::DirectConnection,Q_RETURN_ARG(QVariant,retValue),Q_ARG(QVariant,res));
        // 泄露
    });
}
