#include "netsongurl.h"
#include <QJsonParseError>
#include <QJsonObject>
#include <QJsonDocument>

NetSongUrl::NetSongUrl(QString id,std::function<void(QJsonObject)> cb)
    :NetAPI(QUrl(QString("/music/url?id=")+id))
{
    callback=cb;
    get();
}
void NetSongUrl::then(QNetworkReply *reply,QByteArray data,int code){
    qDebug()<<"then()"<<endl;
    QJsonParseError e;
    QJsonObject ret=QJsonDocument::fromJson(data, &e).object();
    callback(ret);
}
