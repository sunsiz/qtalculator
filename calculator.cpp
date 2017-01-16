#include "calculator.h"

#include "lexer.h"
#include "parser.h"

extern float result;
extern float error;

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
        printf("%f\n", result);

        memo->setProperty("text", strResult);
        resultDisplay->setProperty("text", "");
    }
    else {
        fprintf(stderr, "Error\n");

        memo->setProperty("text", "Invalid expression");
    }

    yy_delete_buffer(bufferState);
}
