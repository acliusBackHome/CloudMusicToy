#ifndef NETSONGURL_H
#define NETSONGURL_H

#include "netapi.h"
#include <QString>

class NetSongUrl : public NetAPI
{
public:
    NetSongUrl(QString id,std::function<void(QJsonObject)>);
protected:
    void then(QNetworkReply *reply,QByteArray byte,int code);
    std::function<void(QJsonObject)> callback;
};

#endif // NETSONGURL_H
