import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

GridLayout {
    anchors.fill: parent
    anchors.margins: 5
    rowSpacing: 0

    columns: 6
    rows: 5

    property var validatorRegExp: /^([(]*)(([0-9]+)+)(?:([-+*\/\^])([(]*)(([0-9]+)+([)]*)))+$/

    function setResult (arg) {
        resultDisplay.text = arg
    }

    function insertOperator (arg) {
        var patt = /^.*[\.\+\-\*/\^]$/;
        if (patt.test(resultDisplay.text)) {
            resultDisplay.text = resultDisplay.text.substring(0, resultDisplay.length - 1) + arg
        }
        else if (resultDisplay.text != "")
            resultDisplay.text += arg
    }

    TextField {
        id: resultDisplay
        objectName: qsTr("resultDisplay")

        focus: true
        //placeholderText: qsTr("0")
        text: qsTr("2+5")

        horizontalAlignment: TextInput.AlignRight
        font.pixelSize: 35

        validator: RegExpValidator { regExp: validatorRegExp }

        Layout.column: 0
        Layout.row: 0
        Layout.columnSpan: 6
        //Layout.columnSpan: 5

        Layout.minimumHeight: 60
        Layout.fillWidth: true
    }

    Text {
        id: memo
        objectName: "memo"
        color: "gray"
        Layout.column: 0
        Layout.row: 1
        Layout.columnSpan: 6

        Layout.minimumHeight: 60
        Layout.fillWidth: true

        horizontalAlignment: Text.AlignRight
        text: qsTr("")
        font.pixelSize: 45
    }

    Keys.onPressed:  {
        var symbol = String.fromCharCode(event.key.valueOf());
        var possible_text = resultDisplay.text + symbol;

        if (validatorRegExp.test(possible_text))
        resultDisplay.text = possible_text;
    }

    Button {
        id: buttonMS
        text: qsTr("MS")
        Layout.column: 0
        Layout.row: 2

        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true
    }

    Button {
        id: buttonMR
        text: qsTr("MR")
        Layout.column: 1
        Layout.row: 2

        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true
    }

    Button {
        id: buttonMplus
        text: qsTr("M+")
        Layout.column: 2
        Layout.row: 2

        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true
    }

    Button {
        id: buttonClear
        text: qsTr("C")
        Layout.column: 3
        Layout.row: 2

        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true
    }

    Button {
        id: buttonAllClear
        text: qsTr("AC")
        Layout.column: 4
        Layout.row: 2

        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true
    }

    Button {
        id: buttonBackSpace
        text: qsTr("<-")
        Layout.column: 5
        Layout.row: 2

        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.text = resultDisplay.text.substring(0, resultDisplay.length - 1)
        }
    }

    Button {
        id: button7
        text: qsTr("7")
        Layout.column: 0
        Layout.row: 3

        Layout.fillHeight: true
        Layout.fillWidth: true
        Shortcut {
            sequence: Qt.Key_7
        }
        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }

    }

    Button {
        id: button8
        text: qsTr("8")
        Layout.column: 1
        Layout.row: 3

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: button9
        text: qsTr("9")
        Layout.column: 2
        Layout.row: 3

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: buttonLeftBracket
        text: qsTr("(")
        Layout.column: 3
        Layout.row: 3

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: buttonRightBracket
        text: qsTr(")")
        Layout.column: 4
        Layout.row: 3

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: buttonPow
        text: qsTr("^")
        Layout.column: 5
        Layout.row: 3

        Layout.fillHeight: true
        Layout.fillWidth: true
        onClicked: {
            insertOperator(this.text)
        }
    }

    Button {
        id: button4
        text: qsTr("4")
        Layout.column: 0
        Layout.row: 4

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: button5
        text: qsTr("5")
        Layout.column: 1
        Layout.row: 4

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: button6
        text: qsTr("6")
        Layout.column: 2
        Layout.row: 4

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: buttonMul
        text: qsTr("*")
        Layout.column: 3
        Layout.row: 4

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            insertOperator(this.text)
        }
    }

    Button {
        id: buttonDiv
        text: qsTr("÷")
        Layout.column: 4
        Layout.row: 4

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            insertOperator("\/")
        }
    }

    Button {
        id: buttonSqrt
        text: qsTr("√")
        Layout.column: 5
        Layout.row: 4

        Layout.fillHeight: true
        Layout.fillWidth: true

        visible: false
    }

    Button {
        id: button1
        text: qsTr("1")
        Layout.column: 0
        Layout.row: 5

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: button2
        text: qsTr("2")
        Layout.column: 1
        Layout.row: 5

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: button3
        text: qsTr("3")
        Layout.column: 2
        Layout.row: 5

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: buttonPercent
        text: qsTr("%")
        Layout.column: 3
        Layout.row: 5

        Layout.fillHeight: true
        Layout.fillWidth: true

        visible: false
    }

    //TO REMOVE
    Button {
        id: buttonRev
        text: qsTr("1/x")
        Layout.column: 4
        Layout.row: 5

        Layout.fillHeight: true
        Layout.fillWidth: true

        visible: false
    }

    Button {
        id: buttonEquals
        text: qsTr("=")
        Layout.column: 5
        //Layout.row: 4
        Layout.row: 4
        Layout.rowSpan: 2

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: evaluateSignal(qsTr(resultDisplay.text))
    }

    Button {
        id: button0
        text: qsTr("0")
        Layout.column: 0
        Layout.row: 6
        Layout.columnSpan: 2

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: buttonPoint
        text: qsTr(".")
        Layout.column: 2
        Layout.row: 6

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            insertOperator(this.text)
        }
    }

    Button {
        id: buttonPlus
        text: qsTr("+")
        Layout.column: 3
        //Layout.row: 5
        Layout.row: 5

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            insertOperator(this.text)
        }
    }

    Button {
        id: buttonMinus
        text: qsTr("−")
        Layout.column: 4
        //Layout.row: 5
        Layout.row: 5

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            insertOperator("-")
        }
    }
}
