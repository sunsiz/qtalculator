import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    minimumHeight: 740
    minimumWidth: 580
    visible: true
    title: qsTr("QTalculator")

    signal evaluateSignal (string arg)
    signal saveMemSignal (string arg)
    signal readMemSignal ()
    signal addMemSignal ()

    CalcLayout {
    }

}
