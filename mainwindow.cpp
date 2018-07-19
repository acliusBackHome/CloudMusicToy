#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "cloudmusicapi.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    navigation=new Navigation(this);
    navigation->toRecommend();
}
MainWindow::~MainWindow()
{
    delete ui;
    delete navigation;
}

void MainWindow::on_checkBox_toggled(bool checked)
{
    qDebug()<<checked<<endl;
}

Navigation::Navigation(MainWindow *p){
    root=p;
    main=0;
    player=new QQuickWidget(root);
    player->setSource(QUrl("../wyytoy/mediaplayer.qml"));
    player->move(0,400);
    player->show();
    mainplayer=new MainPlayer(this,player);
}

Navigation::~Navigation(){
    if(main)delete main;
}

void Navigation::freshen(){
    if(main){
        main->close();
    }
    main=new QQuickWidget(root);
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
