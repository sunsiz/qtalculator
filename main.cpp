#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "calculator.h"

extern float result;

int main(int argc, char *argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    QObject* root = engine.rootObjects()[0];

    Calculator *calc = new Calculator(root);

    QObject::connect(root, SIGNAL(evaluateSignal(QString)),
    calc, SLOT(evaluateSlot(QString)));

    return app.exec();
}
