#include "navigation.h"
#include "mainplayer.h"
#include "cloudmusic/cloudmusicapi.h"
#include "sqlite/litestorage.h"
#include <QJsonArray>
#include <QGraphicsDropShadowEffect>
void Navigation::cntRecommendAlbum(){
    QObject::connect(recommend,SIGNAL(playlistClickSignal(QVariant)),this,SLOT(playlistClickSlot(QVariant)));
}
void Navigation::cntPlayerNowIdStr(){
    QObject::connect((QQuickItem *)(player->rootObject()),SIGNAL(nowIdSignal(QVariant)),this,SLOT(nowIdSlot(QVariant)));
}
void Navigation::cntPlaylistSwitch(){
    QObject::connect((QQuickItem *)(player->rootObject()),SIGNAL(listBtnClickSignal()),this,SLOT(playlistSwitchClickSlot()));
}
void Navigation::cntPopupClearList(){
    QObject::connect(poplist->rootObject(),SIGNAL(clearListSignal()),this,SLOT(clearListSlot()));
}
void Navigation::cntPopupSongClick(){
    QObject::connect(poplist->rootObject(),SIGNAL(pieceClickSignal(QVariant)),this,SLOT(songClickSlot(QVariant)));
}
void Navigation::cntAlbumSongClick(){
    QObject::connect(list,SIGNAL(songClickSignal(QVariant)),this,SLOT(songClickSlot(QVariant)));
}
void Navigation::cntAlbumAllToPlay(){
    QObject::connect(list,SIGNAL(listClickSignal(QVariant)),this,SLOT(listClickSlot(QVariant)));
}
void Navigation::callPopAPlayClear(){
    QMetaObject::invokeMethod(poplist->rootObject(),"clear",Qt::DirectConnection);
    QMetaObject::invokeMethod(player->rootObject(),"clear",Qt::DirectConnection);
}
void Navigation::callRmdCreateList(QVariant arg){
    QMetaObject::invokeMethod(recommend,"createItems",Qt::DirectConnection,Q_ARG(QVariant,arg));
}
void Navigation::callPopCreateList(QVariant arg){
    QMetaObject::invokeMethod(poplist->rootObject(),"createList",Qt::DirectConnection,Q_ARG(QVariant,arg)); // auto downcast
}
void Navigation::callDtlCreateList(QVariant arg){
    QMetaObject::invokeMethod(list,"nextTick",Qt::DirectConnection,Q_ARG(QVariant,arg));
}
void Navigation::updateRB(){
    QMetaObject::invokeMethod(player->rootObject(),"setListNum",Qt::DirectConnection,Q_ARG(QVariant,QVariant(mainplayer->playlist.length())));
}
void Navigation::updateLB(QString id){
    if(id=="nonenone")return;
    NetSongDetails *k=new NetSongDetails(id,[&](QVariant res){
        QMetaObject::invokeMethod(smBox->rootObject(),"freshen",Qt::DirectConnection,Q_ARG(QVariant,res));
    });
}
Navigation::Navigation(QWidget *p){
    root=p;
    main=0;
    list=0;
    recommend=0;

    player=new QQuickWidget(root);
    player->setSource(QUrl("qrc:/qml/mediaplayer.qml"));
    player->move(10,670 + 10 - 47);
    player->resize(1024,48);
    player->show();
    mainplayer=new MainPlayer(this,player);
    cntPlaylistSwitch();
    cntPlayerNowIdStr();

    smBox=new QQuickWidget(root);
    smBox->setSource(QUrl("qrc:/qml/smallbox.qml"));
    smBox->resize(200,60);
    smBox->move(10,670-60-50+10+3);
    smBox->show();

    poplist=0;

    this->rarium = new LiteStorage;
    mainplayer->playlist=rarium->getListIds(); // 读取数据库数据
    QVariant arg;
    arg.setValue(mainplayer->playlist);
    QMetaObject::invokeMethod(player->rootObject(),"freshList",Q_ARG(QVariant,arg)); // 刷新QML playlist
    updateRB(); // 更新right bottom number
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
}

void Navigation::toRecommend(){
    this->freshen();
    main->setSource(QUrl("qrc:/qml/recommend.qml"));
    recommend=main->rootObject();
    cntRecommendAlbum();
    NetRecommend *k=new NetRecommend([&](QVariant res){
        qDebug()<<"这是魔法的输出"<<endl;
        callRmdCreateList(res);
        // 泄露
    });
}

void Navigation::openPopList(){
    poplist=new QQuickWidget(root);
    poplist->setSource(QUrl("qrc:/qml/Poplist.qml"));
    poplist->resize(580,477);
    poplist->move(1024-580+10,670-477-48+10);
    poplist->show();

    callPopCreateList(rarium->getList());
    cntPopupSongClick();
    cntPopupClearList();
}

void Navigation::closePopList(){
    if(poplist==0)return;
    poplist->close();
    delete poplist;
    poplist=0;
}

void Navigation::toList(QString id){
    this->freshen();
    main->setSource(QUrl("qrc:/qml/list.qml"));
    list=main->rootObject();
    cntAlbumSongClick();
    cntAlbumAllToPlay();
    NetPlaylistDetails *k=new NetPlaylistDetails(id,[&](QVariant res){
        rarium->addDetails(res.toJsonObject()["playlist"].toVariant().toJsonObject()["tracks"].toVariant().toJsonArray());
        callDtlCreateList(res);
        // 泄露
    });
}

void Navigation::playlistClickSlot(QVariant id){
    this->toList(id.toString());
}

void Navigation::songClickSlot(QVariant id){
    rarium->addSid(id.toString()); // 存储到 playlist id 数据表
    mainplayer->newPlay(id.toString());
    updateRB();
    updateLB(id.toString());
    if(poplist)callPopCreateList(rarium->getList());
}

void Navigation::listClickSlot(QVariant listIds){
    QStringList lists=listIds.toStringList(); // add to playlist ids 数据库
    for(int i=0;i<lists.size();i++){
        mainplayer->addToList(lists[i]);
        // rarium->addSid(lists[i]); //效率低下，应该使用事务
    }
    rarium->addSids(lists);
    updateRB();
}

void Navigation::playlistSwitchClickSlot(){
    static bool listBtnState=true;
    if(listBtnState){
        this->openPopList();
    }else{
        this->closePopList();
    }
    listBtnState=!listBtnState;
}

void Navigation::clearListSlot() {
    rarium->clearSids();
    callPopAPlayClear();
    mainplayer->playlist.clear();
    updateRB();
}
void Navigation::nowIdSlot(QVariant sid){
    QRegExp rx("id=\\d+(?=.mp3)");
    qDebug()<<sid.toString().indexOf(rx);
    QString quid=rx.capturedTexts()[0];
    updateLB(quid.split("=")[1]);
}
