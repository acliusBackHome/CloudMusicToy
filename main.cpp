#include "mainwindow.h"
#include "netrecommend.h"
#include <QApplication>
#include <QMediaPlayer>
#include <QUrl>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    return a.exec();
}
