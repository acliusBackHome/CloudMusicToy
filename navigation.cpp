#include "navigation.h"
#include "cloudmusic/cloudmusicapi.h"

Navigation::Navigation(QWidget *p){
    root=p;
    main=0;
    player=new QQuickWidget(root);
    player->setSource(QUrl("../wyytoy/mediaplayer.qml"));
    player->move(10,670 + 10 - 47);
    player->resize(1024,48);
    player->show();
    mainplayer=new MainPlayer(this,player);
}

Navigation::~Navigation(){
    if(main)delete main;
    if(mainplayer)delete mainplayer;
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
    main->setSource(QUrl("../wyytoy/recommend.qml"));
    recommend=main->rootObject();
    QObject::connect(recommend,SIGNAL(playlistClickSignal(QVariant)),this,SLOT(playlistClickSlot(QVariant)));
    NetRecommend *k=new NetRecommend([&](QVariant res){
        qDebug()<<"call me"<<endl;
        QVariant retValue;
        QMetaObject::invokeMethod(recommend,"createItems",Qt::DirectConnection,Q_RETURN_ARG(QVariant, retValue),Q_ARG(QVariant,res));
        delete k;
    });
}

void Navigation::toList(QString id){
    qDebug()<<id<<endl;
    this->freshen();
    main->setSource(QUrl("../wyytoy/list.qml"));
    list=main->rootObject();
    QObject::connect(list,SIGNAL(songClickSignal(QVariant)),this,SLOT(songClickSlot(QVariant)));
    NetPlaylistDetails *k=new NetPlaylistDetails(id,[&](QVariant res){
        QVariant retValue;
        QMetaObject::invokeMethod(list,"nextTick",Qt::DirectConnection,Q_RETURN_ARG(QVariant,retValue),Q_ARG(QVariant,res));
        // 泄露
    });
}

void Navigation::playlistClickSlot(QVariant id){
    qDebug()<<id<<endl;
    this->toList(id.toString());
}

void Navigation::songClickSlot(QVariant id){
    qDebug()<<id<<endl;
    mainplayer->newPlay(id.toString());
}

