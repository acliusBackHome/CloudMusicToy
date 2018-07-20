#ifndef LABEL_H
#define LABEL_H
#include <QLabel>

class CloseLabel : public QLabel
{
    Q_OBJECT
public:
    bool event(QEvent *event);
    explicit CloseLabel(QWidget *parent = 0);
protected:
    void mouseReleaseEvent(QMouseEvent *);
};

#endif // LABEL_H
