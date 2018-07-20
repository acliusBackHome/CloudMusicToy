#include "netrecommend.h"
#include <QJsonObject>
#include <QJsonParseError>
#include <QJsonDocument>
NetRecommend::NetRecommend(std::function<void(QJsonObject)> cb)
    :NetAPI(QUrl("/personalized"))
{
    callback=cb; // 设置回调
    get(); // 开始http请求
}
void NetRecommend::then(QNetworkReply *reply,QByteArray data,int code){ // 请求成功后调用此方法
    qDebug()<<"then()"<<endl;
    QJsonParseError e;
    QJsonObject ret=QJsonDocument::fromJson(data, &e).object(); // 解析Byte为JSon对象
    // qDebug()<<ret["result"]<<endl;
    callback(ret); // 调用用户自定义的回调方法，并传递QJsonObject(json对象)
}
/* how to use *
 * NetRecommend kiko([](QJsonObject res){
 *   qDebug()<<res<<endl;
 * });
 */
