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
void MainPlayer::toBack(){
    if(playlist.empty())return;
    index=playlist.length()-1;
}
QString MainPlayer::nextStr(){
    if(playlist.empty())return "nonenone";
    index--;
    if(index<0)toBack();
    return playlist[index];
}
QString MainPlayer::prevStr(){
    if(playlist.empty())return "nonenone";
    index++;
    if(index>=playlist.length())index=0;
    return playlist[index];
}
QString MainPlayer::nowsStr(){
    if(playlist.empty())return "nonenone";
    return playlist[index];
}
void MainPlayer::next(){
    QString sid=nextStr();
    if(sid!="nonenone")newPlay(sid);
}
void MainPlayer::prev(){
    QString sid=prevStr();
    if(sid!="nonenone")newPlay(sid);
}
