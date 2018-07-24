#ifndef MAINPLAYER_H
#define MAINPLAYER_H

#include <QObject>
#include <QQuickWidget>

class MainPlayer : public QObject
{
    Q_OBJECT
public:
    explicit MainPlayer(QObject *parent = nullptr, QQuickWidget *p = 0);
    QQuickWidget *player;
    QVector<QString> playlist;
    int index;
    void addToList(QString);
    void newPlay(QString);
signals:

public slots:
};

#endif // MAINPLAYER_H
