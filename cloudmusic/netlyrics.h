#ifndef LYRICS_H
#define LYRICS_H

#include "netapi.h"
#include <QJsonObject>

class NetLyrics : public NetAPI
{
public:
    NetLyrics(QString id,std::function<void(QJsonObject)>cb);

protected:
    void then(QNetworkReply *reply, QByteArray data, int code);
    std::function<void(QJsonObject)> callback;
};
#endif // LYRICS_H
