#include "mylayout.h"
#include "ui_mylayout.h"

MyLayout::MyLayout(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::MyLayout)
{
    ui->setupUi(this);
}

MyLayout::~MyLayout()
{
    delete ui;
}
