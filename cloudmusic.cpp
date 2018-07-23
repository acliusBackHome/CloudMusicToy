#include "cloudmusic.h"
#include "closelabel.h"
#include "navigation.h"
#include "ui_cloudmusic.h"
#include <QGraphicsDropShadowEffect>

CloudMusic::CloudMusic(QWidget *parent) :
    QWidget(parent),ui(new Ui::CloudMusic)
{
    ui->setupUi(this);
    this->setWindowFlag(Qt::FramelessWindowHint);
    this->setAttribute(Qt::WA_TranslucentBackground);
    this->resize(QSize(1024 + 20,670 + 30));

    auto shadowEffect=new QGraphicsDropShadowEffect(this);
    shadowEffect->setBlurRadius(12);
    shadowEffect->setOffset(0,0);
    ui->frame->setGraphicsEffect(shadowEffect);

    closeLabel=new CloseLabel(this);
    closeLabel->installEventFilter(this);

    navigation=new Navigation(this);
    navigation->toRecommend();
}

CloudMusic::~CloudMusic(){
    delete ui;
    delete closeLabel;
    delete navigation;
}

bool CloudMusic::eventFilter(QObject *obj, QEvent *event)
{
    if(obj==closeLabel){
        if(event->type()==QEvent::MouseButtonRelease){
            qDebug("CloudMusic Main Widget filter");
            close();
        }
    }
    return QWidget::eventFilter(obj,event);
}

void CloudMusic::on_min_clicked()
{
    this->showMinimized();
}

void CloudMusic::mousePressEvent(QMouseEvent *event){
    if(event->button()==Qt::LeftButton){
        offset=event->globalPos()-pos();
    }
}

void CloudMusic::mouseMoveEvent(QMouseEvent *event){
    if(event->buttons()&Qt::LeftButton){
        this->move(event->globalPos()-offset);
    }
}

void CloudMusic::on_back_clicked()
{
    navigation->toRecommend();
}
