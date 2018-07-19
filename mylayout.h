#ifndef MYLAYOUT_H
#define MYLAYOUT_H

#include <QWidget>

namespace Ui {
class MyLayout;
}

class MyLayout : public QWidget
{
    Q_OBJECT

public:
    explicit MyLayout(QWidget *parent = 0);
    ~MyLayout();

private:
    Ui::MyLayout *ui;
};

#endif // MYLAYOUT_H
