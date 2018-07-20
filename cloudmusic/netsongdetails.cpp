#include "netsongdetails.h"
#include <QJsonObject>
#include <QJsonParseError>
#include <QJsonDocument>
#include <QString>

NetSongDetails::NetSongDetails(QString id,std::function<void(QJsonObject)> cb)
    :NetAPI(QString("/song/detail?ids=")+id)
{
    callback=cb;
    get();
}
void NetSongDetails::then(QNetworkReply *reply, QByteArray data, int code)
{
    QJsonParseError e;
    QJsonObject ret=QJsonDocument::fromJson(data, &e).object();
    callback(ret);
}
