#ifndef NAVIGATION_H
#define NAVIGATION_H

#include <QObject>
#include <QQuickWidget>
#include <QQuickItem>

class LiteStorage;
class MainPlayer;

class Navigation:public QObject {
    Q_OBJECT

public:
    QWidget *root;
    QQuickWidget *main;
    QQuickWidget *player;
    QQuickWidget *smBox;
    QQuickItem *recommend;
    QQuickItem *list;
    QQuickWidget *poplist;
    MainPlayer *mainplayer;
    LiteStorage *rarium;

    void toRecommend();
    void toList(QString id);
    void toList(QVariant var);
    void openPopList();
    void closePopList();
    void freshen();
    void updateRB();
    explicit Navigation(QWidget *p=0);
    ~Navigation();

public slots:
    void playlistClickSlot(QVariant); // playlist icon click
    void songClickSlot(QVariant); // song in playlist click
    void listClickSlot(QVariant); // play all list button click
    void listBtnClickSlot(); // show or close playing list button click
    void clearListSlot(); // clear btn click

};

#endif // NAVIGATION_H
