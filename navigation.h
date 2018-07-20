#ifndef NAVIGATION_H
#define NAVIGATION_H

#include <QObject>
#include <QQuickWidget>
#include <QQuickItem>
#include "mainplayer.h"

class Navigation:public QObject {
    Q_OBJECT

public:
    QWidget *root;
    QQuickWidget *main;
    QQuickWidget *player;
    QQuickItem *recommend;
    QQuickItem *list;
    MainPlayer *mainplayer;
    void toRecommend();
    void toList(QString id);
    void toList(QVariant var);
    void freshen();
    explicit Navigation(QWidget *p=0);
    ~Navigation();

public slots:
    void playlistClickSlot(QVariant);
    void songClickSlot(QVariant);
};

#endif // NAVIGATION_H
