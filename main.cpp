#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "lexer.h"
#include "parser.h"

extern float result;

int main(int argc, char *argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    QString str("1.123+1");

    YY_BUFFER_STATE bufferState = yy_scan_string(str.toUtf8().constData());

    yyparse();

    printf("%f\n", result);

    yy_delete_buffer(bufferState);

    return app.exec();
}
