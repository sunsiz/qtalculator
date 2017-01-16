#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <QObject>
#include <QVariant> //wut is dis

class Calculator : public QObject
{
    Q_OBJECT
public:
    explicit Calculator(QObject *parent = 0);

signals:

public slots:
    void evaluateSlot(const QString &arg);
    void saveMemSlot(const QString &arg);
    void readMemSlot();
    void addMemSlot();
};

#endif // CALCULATOR_H
