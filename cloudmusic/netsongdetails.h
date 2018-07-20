#ifndef DETAILS_H
#define DETAILS_H

#include "netapi.h"
#include <QJsonObject>

class NetSongDetails:public NetAPI
{
public:
    NetSongDetails(QString id,std::function<void(QJsonObject)>cb);
protected:
    void then(QNetworkReply *reply, QByteArray data, int code);
    std::function<void(QJsonObject)> callback;
};

#endif // DETAILS_H


