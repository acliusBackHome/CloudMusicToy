#include "netcomment.h"
#include <QJsonObject>
#include <QJsonParseError>
#include <QJsonDocument>

NetComment::NetComment(QString id,std::function<void(QJsonObject)> cb)
    :NetAPI(QString("/comment/music?id=")+id+QString("&limit=20"))
{
            callback=cb;
            get();
}
void NetComment::then(QNetworkReply *reply, QByteArray data, int code)
{
            QJsonParseError e;
            QJsonObject ret=QJsonDocument::fromJson(data, &e).object();
            callback(ret);
}
