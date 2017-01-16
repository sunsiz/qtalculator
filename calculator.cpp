#include "calculator.h"

#include "lexer.h"
#include "parser.h"

extern float result;
extern float error;

float mem;
char memIsFull = 0;

Calculator::Calculator(QObject *parent) : QObject(parent) {

}

void Calculator::evaluateSlot(const QString &arg) {
    QObject* resultDisplay = this->parent()->findChild<QObject*>("resultDisplay");
    QObject* memo = this->parent()->findChild<QObject*>("memo");

    error = 0;

    QByteArray ba = arg.toLatin1();
    const char *expression = ba.data();

    YY_BUFFER_STATE bufferState = yy_scan_string(expression);
    yyparse();

    QString strResult = QString::number(result);

    if(!error) {
        printf("Result %f\n", result);

        memo->setProperty("text", strResult);
        resultDisplay->setProperty("text", "");
    }
    else {
        fprintf(stderr, "Error\n");

        memo->setProperty("text", "Invalid");
    }

    yy_delete_buffer(bufferState);
}

void Calculator::saveMemSlot(const QString &arg) {
    QObject* memo = this->parent()->findChild<QObject*>("memo");
    mem = memo->property("text").toFloat();
    printf("Saved to mem %f\n", mem);
    memIsFull = 1;
}

void Calculator::readMemSlot() {
    QObject* resultDisplay = this->parent()->findChild<QObject*>("resultDisplay");
    QString strResult = QString::number(mem);
    resultDisplay->setProperty("text", strResult);
}

void Calculator::addMemSlot() {
    QObject* memo = this->parent()->findChild<QObject*>("memo");
    mem += memo->property("text").toFloat();
    printf("Added to mem. Now mem is %f\n", mem);
}
