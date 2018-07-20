#include "netplaylistdetails.h"
#include <QJsonObject>
#include <QJsonParseError>
#include <QJsonDocument>
#include <QString>

NetPlaylistDetails::NetPlaylistDetails(QString id,std::function<void(QJsonObject)> cb)
    :NetAPI(QString("/playlist/detail?id=")+id)
{
    callback=cb;
    get();
}
void NetPlaylistDetails::then(QNetworkReply *reply, QByteArray data, int code)
{
    qDebug()<<"then"<<endl;
    QJsonParseError e;
    QJsonObject ret=QJsonDocument::fromJson(data, &e).object();
    callback(ret);
}
