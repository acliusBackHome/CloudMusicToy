#ifndef NETRECOMMEND_H
#define NETRECOMMEND_H

#include "netapi.h"
#include <QJsonObject>
/* api示例 */
class NetRecommend : public NetAPI
{
public:
    NetRecommend(std::function<void(QJsonObject)> cb); // 构造函数，接收一个用户自定义的回调方法
protected:
    void then(QNetworkReply *reply,QByteArray byte,int code); // 重写基类的虚函数
    std::function<void(QJsonObject)> callback; // 存放用户自定义的回调函数
};

#endif // NETRECOMMEND_H
