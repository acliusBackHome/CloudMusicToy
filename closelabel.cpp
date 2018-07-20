#include "closelabel.h"
#include <QKeyEvent>
CloseLabel::CloseLabel(QWidget *parent):QLabel(parent)
{
    setCursor(Qt::PointingHandCursor);
    move(1024 - 30,20);
    resize(QSize(30,30));
    setAlignment(Qt::AlignHCenter|Qt::AlignVCenter);
    setStyleSheet("QLabel{"
                  "background:#c62f2f;"
                  "color:#fff;"
                  "cursor:pointer;"
                  "color:#e29595;"
                  "font-size: 20px;"
                  "}"
                  "QLabel:hover{"
                  "color: #fff;"
                  "}");
    setText(QString("×"));
}
void CloseLabel::mouseReleaseEvent(QMouseEvent *event)
{
    qDebug("CloseLabel Mouse Release Event");
}
bool CloseLabel::event(QEvent *event)
{
    if(event->type()==QEvent::MouseButtonRelease){
        qDebug("CloseLabel Mouse Button Belease");
    }
    return QLabel::event(event);
}
