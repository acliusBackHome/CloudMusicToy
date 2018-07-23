#include "navigation.h"
#include "mainplayer.h"
#include "cloudmusic/cloudmusicapi.h"
#include "sqlite/litestorage.h"
#include <QJsonArray>
#include <QGraphicsDropShadowEffect>

Navigation::Navigation(QWidget *p){
    root=p;
    main=0;

    player=new QQuickWidget(root);
    player->setSource(QUrl("qrc:/qml/mediaplayer.qml"));
    player->move(10,670 + 10 - 47);
    player->resize(1024,48);
    player->show();
    mainplayer=new MainPlayer(this,player);
    QObject::connect((QQuickItem *)(player->rootObject()),SIGNAL(listBtnClickSignal()),this,SLOT(listBtnClickSlot()));

    smBox=new QQuickWidget(root);
    smBox->setSource(QUrl("qrc:/qml/smallbox.qml"));
    smBox->resize(200,60);
    smBox->move(10,670-60-50+10+3);
    smBox->show();

    poplist=0;

    this->rarium = new LiteStorage;
    mainplayer->playlist=rarium->getListIds();
    updateRB();
}

Navigation::~Navigation(){
    if(main)delete main;
    if(mainplayer)delete mainplayer;
    delete player;
    if(poplist)delete poplist;
    delete rarium;
    delete smBox;
}

void Navigation::freshen(){
    if(main){
        main->close();
    }
    main=new QQuickWidget(root);
    main->move(210,60);
    main->resize(1024-200,670-50-49);
    main->show();
    // recommend=0;
    // list=0;
}

void Navigation::toRecommend(){
    this->freshen();
    main->setSource(QUrl("qrc:/qml/recommend.qml"));
    recommend=main->rootObject();
    QObject::connect(recommend,SIGNAL(playlistClickSignal(QVariant)),this,SLOT(playlistClickSlot(QVariant)));
    NetRecommend *k=new NetRecommend([&](QVariant res){
        qDebug()<<"call me"<<endl;
        QVariant retValue;
        QMetaObject::invokeMethod(recommend,"createItems",Qt::DirectConnection,Q_RETURN_ARG(QVariant, retValue),Q_ARG(QVariant,res));
        delete k;
    });
}

void Navigation::openPopList(){
    poplist=new QQuickWidget(root);
    poplist->setSource(QUrl("qrc:/qml/Poplist.qml"));
    poplist->resize(580,477);
    poplist->move(1024-580+10,670-477-48+10);
    poplist->show();

    QMetaObject::invokeMethod(poplist->rootObject(),"createList",Qt::DirectConnection,Q_ARG(QVariant,rarium->getList())); // auto downcast
    QObject::connect(poplist->rootObject(),SIGNAL(pieceClickSignal(QVariant)),this,SLOT(songClickSlot(QVariant)));
    QObject::connect(poplist->rootObject(),SIGNAL(clearListSignal()),this,SLOT(clearListSlot()));
}

void Navigation::closePopList(){
    if(poplist==0)return;
    poplist->close();
    delete poplist;
    poplist=0;
}

void Navigation::toList(QString id){
    qDebug()<<id<<endl;
    this->freshen();
    main->setSource(QUrl("qrc:/qml/list.qml"));
    list=main->rootObject();
    QObject::connect(list,SIGNAL(songClickSignal(QVariant)),this,SLOT(songClickSlot(QVariant)));
    QObject::connect(list,SIGNAL(listClickSignal(QVariant)),this,SLOT(listClickSlot(QVariant)));
    NetPlaylistDetails *k=new NetPlaylistDetails(id,[&](QVariant res){
        QVariant retValue;
        rarium->addDetails(res.toJsonObject()["playlist"].toVariant().toJsonObject()["tracks"].toVariant().toJsonArray());
        QMetaObject::invokeMethod(list,"nextTick",Qt::DirectConnection,Q_RETURN_ARG(QVariant,retValue),Q_ARG(QVariant,res));
        // 泄露
    });
}

void Navigation::updateRB(){
    QMetaObject::invokeMethod(player->rootObject(),"setListNum",Qt::DirectConnection,Q_ARG(QVariant,QVariant(mainplayer->playlist.length())));
}
void Navigation::playlistClickSlot(QVariant id){
    qDebug()<<id<<endl;
    this->toList(id.toString());
}

void Navigation::songClickSlot(QVariant id){
    qDebug()<<id<<endl;
    rarium->addSid(id.toString());
    mainplayer->newPlay(id.toString());
    updateRB();
    NetSongDetails *k=new NetSongDetails(id.toString(),[&](QVariant res){
        // qDebug()<<res<<endl;
        QMetaObject::invokeMethod(smBox->rootObject(),"freshen",Qt::DirectConnection,Q_ARG(QVariant,res));
    });

}

void Navigation::listClickSlot(QVariant listIds){
    QStringList lists=listIds.toStringList();
    for(int i=0;i<lists.size();i++){
        qDebug()<<lists[i]<<endl;
        mainplayer->addToList(lists[i]);
        // rarium->addSid(lists[i]); //效率低下，应该使用事务
    }
    rarium->addSids(lists);
    updateRB();
}

void Navigation::listBtnClickSlot(){
    static bool listBtnState=true;
    if(listBtnState){
        qDebug()<<"show"<<endl;
        this->openPopList();
    }else{
        qDebug()<<"close"<<endl;
        this->closePopList();
    }
    listBtnState=!listBtnState;
}

void Navigation::clearListSlot() {
    rarium->clearSids();
    QMetaObject::invokeMethod(poplist->rootObject(),"clear",Qt::DirectConnection);
    mainplayer->playlist.clear();
    updateRB();
}
