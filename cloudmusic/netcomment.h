#ifndef NETCOMMENT_H
#define NETCOMMENT_H

#include "netapi.h"
#include <QJsonObject>
class NetComment : public NetAPI
{
public:
    NetComment(QString id,std::function<void(QJsonObject)> cb);
protected:
    void then(QNetworkReply *reply,QByteArray byte,int code);
    std::function<void(QJsonObject)> callback;
};

#endif // NETCOMMENT_H
