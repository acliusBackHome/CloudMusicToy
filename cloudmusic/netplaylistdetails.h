#ifndef PLAYLISTDETAIS_H
#define PLAYLISTDETAIS_H

#include "netapi.h"
#include <QJsonObject>

class NetPlaylistDetails:public NetAPI
{
public:
    NetPlaylistDetails(QString id,std::function<void(QJsonObject)>cb);
protected:
    void then(QNetworkReply *reply,QByteArray data,int code);
    std::function<void(QJsonObject)> callback;
};

#endif // PLAYLISTDETAIS_H
