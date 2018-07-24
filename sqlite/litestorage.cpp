#include "litestorage.h"
#include <QDebug>
#include <QSqlQuery>
#include <QJsonObject>

const QString LiteStorage::filename="forever41.db";

LiteStorage::LiteStorage(QObject *parent) : QObject(parent)
{
    database=QSqlDatabase::addDatabase("QSQLITE");
    database.setDatabaseName(filename);
    if(!database.open()){
        qDebug()<<"database open error"<<endl;
    }
    if(!database.tables().contains("playlist")){
        qDebug()<<"datatable playlist not exist"<<endl;
        qDebug()<<"creating"<<endl;
        QSqlQuery q;
        q.exec("create table playlist (sid text);");
    }
    if(!database.tables().contains("songdetails")){
        qDebug()<<"datatable songdetails not exist"<<endl;
        qDebug()<<"creating"<<endl;
        QSqlQuery q;
        q.exec("create table songdetails (sid text PRIMARY KEY, name text, arname text, dt int);");
        /* sid: song id
         * name: song title
         * arname: singer name
         * dt: song time (ms)
         */
    }
}
LiteStorage::~LiteStorage(){
    database.close();
}
void LiteStorage::addSid(QString sid){
    QSqlQuery q;
    q.exec(QString("INSERT INTO playlist VALUES (%1);").arg(sid));
}
void LiteStorage::addSids(QStringList &sids){
    QSqlQuery q;
    database.transaction();
    foreach(QString sid,sids){
        q.exec(QString("INSERT INTO playlist VALUES (%1);").arg(sid));
    }
    database.commit();
}
void LiteStorage::clearSids(){
    QSqlQuery q;
    q.exec("DELETE FROM playlist;");
}
void LiteStorage::rmASid(QString sid){
    QSqlQuery q;
    q.exec(QString("DELETE FROM playlist WHERE sid = %1").arg(sid));
}
void LiteStorage::addDetails(QJsonArray ds){
    QSqlQuery q;
    database.transaction();
    foreach(QJsonValue item,ds){
        QJsonObject aitem=item.toVariant().toJsonObject();
        QString qstr=QString("REPLACE INTO songdetails (sid, name, arname, dt) VALUES ('%1', '%2', '%3', '%4');")
                .arg(aitem["id"].toInt())
                .arg(aitem["name"].toString())
                .arg(aitem["ar"].toArray()[0].toVariant().toJsonObject()["name"].toString())
                .arg(aitem["dt"].toInt());
        // qDebug()<<qstr<<endl;
        q.exec(qstr);
    }
    database.commit();
}
QVariantList LiteStorage::getList(){
    QSqlQuery q;
    QVariantList ret;
    q.exec("SELECT * FROM songdetails INNER JOIN playlist ON songdetails.sid = playlist.sid;");
    while(q.next()){
        QStringList a;
        for(int i=0;i<4;i++){
            a.push_back(q.value(i).toString());
        }
        ret<<a;
    }
    return ret;
}
QVector<QString> LiteStorage::getListIds(){
    QSqlQuery q;
    QVector<QString> ret;
    q.exec("SELECT sid FROM playlist;");
    while(q.next()){
        ret.push_back(q.value(0).toString());
    }
    return ret;
}
