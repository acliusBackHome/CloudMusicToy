#ifndef LITESTORAGE_H
#define LITESTORAGE_H

#include <QObject>
#include <QSqlDatabase>
#include <QString>
#include <QJsonArray>

class LiteStorage : public QObject
{
    Q_OBJECT
public:
    explicit LiteStorage(QObject *parent = nullptr);
    ~LiteStorage();
    void addSid(QString);
    void addSids(QStringList &);
    void clearSids();
    void rmASid(QString);
    void addDetails(QJsonArray);
    QVariantList getList();
    QVector<QString> getListIds();
protected:
    const static QString filename;
    QSqlDatabase database;

signals:

public slots:
};

#endif // LITESTORAGE_H
