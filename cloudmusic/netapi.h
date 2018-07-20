#ifndef NETAPI_H
#define NETAPI_H
#include <QObject>
#include <QUrl>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
/* 网络操作基类 */
class NetAPI : public QObject
{
    Q_OBJECT
    static QUrl base; // url base
    QUrl url; // 完整url
    QNetworkAccessManager manager; // 管理器
    QNetworkRequest request; // 请求的对象
public:
    NetAPI(QUrl api);
    ~NetAPI();
protected:
    void get();
    virtual void then(QNetworkReply *reply,QByteArray data,int code)=0; // 子类实现
public slots:
    void getRes(QNetworkReply*); // request完成时call
};

#endif // NETAPI_H
