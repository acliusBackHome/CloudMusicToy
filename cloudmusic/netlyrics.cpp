#include "netlyrics.h"
#include <QJsonObject>
#include <QJsonParseError>
#include <QJsonDocument>
#include <QString>

NetLyrics::NetLyrics(QString id,std::function<void(QJsonObject)> cb)
    :NetAPI(QString("/lyric?id=")+id)
{
    callback=cb;
    get();
}
void NetLyrics::then(QNetworkReply *reply, QByteArray data, int code)
{
    QJsonParseError e;
    QJsonObject ret=QJsonDocument::fromJson(data, &e).object();
    callback(ret);
}
