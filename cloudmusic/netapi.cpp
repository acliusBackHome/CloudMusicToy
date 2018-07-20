#include "netapi.h"
#include <QDebug>
/* NetAPI基类实现 */
QUrl NetAPI::base=QUrl("http://111.231.98.20:3000"); // 设置base url
NetAPI::NetAPI(QUrl api)
{
    url = base.toString() + api.toString(); // 设置完整url
    QObject::connect(&manager,SIGNAL(finished(QNetworkReply*)),this,SLOT(getRes(QNetworkReply*))); // 关联信号量和信号槽
    qDebug()<<url<<endl;
}
NetAPI::~NetAPI(){
    manager.disconnect(); // 结束
}
void NetAPI::get(){
    request.setUrl(url); // 设置request对象
    manager.get(request); // 管理器开始request
    qDebug()<<"manager get()"<<endl;
}
void NetAPI::getRes(QNetworkReply *reply){ // 管理器开始的request结束时call this
    qDebug()<<"getRes()"<<endl;
    int code=reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt(); // http get状态量
    // if(reply->error()==QNetworkReply::NoError){
    if(code==200){ // 200为返回正常
        // qDebug()<<reply->readAll()<<endl;
        // 注意：readAll will clear reader
        qDebug()<<"200"<<endl;
        then(reply,reply->readAll(),code); // 调用子类实现的then()
    }else{
        qDebug()<<"error"<<endl;
    }
    reply->deleteLater(); // 如名
}
void NetAPI::then(QNetworkReply *reply,QByteArray data,int code){}
