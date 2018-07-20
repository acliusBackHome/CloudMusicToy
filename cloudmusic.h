#ifndef CLOUDMUSIC_H
#define CLOUDMUSIC_H

#include <QWidget>
#include <QPoint>

namespace Ui {
    class CloudMusic;
}

class CloseLabel;
class Navigation;

class CloudMusic : public QWidget
{
    Q_OBJECT
public:
    Navigation *navigation;
    explicit CloudMusic(QWidget *parent = nullptr);
    virtual ~CloudMusic();
    bool eventFilter(QObject *obj, QEvent *event);
private:
    Ui::CloudMusic *ui;
    CloseLabel *closeLabel;
    QPoint offset;
protected:
    void mousePressEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);
signals:

public slots:
private slots:
    void on_min_clicked();
};

#endif // CLOUDMUSIC_H
