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

    property var validatorRegExp: /^([(]*)(([1-9]+[0]*)|([1-9]+[0]*\.[0-9]))(?:([-+*\/\^])([(]*)((([1-9]+[0]*)|([1-9]+[0]*\.[0-9]+))([)]*)))+$/

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

    Keys.onPressed:  {
        switch(event.key) {
        case Qt.Key_Backspace:
            resultDisplay.text = resultDisplay.text.substring(0, resultDisplay.length - 1)
            break
        case Qt.Key_Delete:
            resultDisplay.text = ""
            break
        case Qt.Key_Control:
            saveMemSignal(memo.text)
            buttonMR.enabled = true
            buttonMplus.enabled = true
            break
        case Qt.Key_Alt:
            if (buttonMR.enabled) readMemSignal()
            break
        case Qt.Key_Shift:
            if (buttonMplus.enabled) addMemSignal()
            break
        case Qt.Key_Enter:
            evaluateSignal(qsTr(resultDisplay.text));
            break
        case Qt.Key_Return:
            evaluateSignal(qsTr(resultDisplay.text));
            break
        case Qt.Key_Escape:
            resultDisplay.text = ""
            memo.text = "0"
            break
        }
    }

    TextField {
        id: resultDisplay
        objectName: qsTr("resultDisplay")

        focus: true
        placeholderText: qsTr("0")

        horizontalAlignment: TextInput.AlignRight
        font.pixelSize: 35

        validator: RegExpValidator { regExp: validatorRegExp }

        Layout.column: 0
        Layout.row: 0
        Layout.columnSpan: 5

        onFocusChanged: resultDisplay.forceActiveFocus()
        Layout.minimumHeight: 60
        Layout.fillWidth: true

    }

    Text {
        id: memo
        objectName: "memo"
        color: "gray"
        Layout.column: 0
        Layout.row: 1
        Layout.columnSpan: 5

        Layout.minimumHeight: 60
        Layout.fillWidth: true

        horizontalAlignment: Text.AlignRight
        text: qsTr("0")
        font.pixelSize: 45

        onTextChanged: {
            if(/[0-9]+|[0-9]+\.[0-9]+/.test(memo.text)) {
                buttonMS.enabled = true;
            } else {
                buttonMS.enabled = false;
            }
        }
    }

    Button {
        id: buttonMS
        text: qsTr("MS")

        Layout.column: 0
        Layout.row: 2

        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true

        ToolTip.text: "Save to memory (Ctrl)"
        hoverEnabled: true
        ToolTip.visible: hovered

        onClicked: {
            saveMemSignal(qsTr(memo.text))
            buttonMR.enabled = true
            buttonMplus.enabled = true
        }
    }

    Button {
        id: buttonMR
        text: qsTr("MR")
        Layout.column: 1
        Layout.row: 2

        enabled: false

        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true

        ToolTip.text: "Read from memory (Alt)"
        hoverEnabled: true
        ToolTip.visible: hovered

        onClicked: readMemSignal()

    }

    Button {
        id: buttonMplus
        text: qsTr("M+")
        Layout.column: 2
        Layout.row: 2

        enabled: false

        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true

        ToolTip.text: "Add to value in memory (Shift)"
        hoverEnabled: true
        ToolTip.visible: hovered

        onClicked: addMemSignal()
    }

    Button {
        id: buttonClear
        text: qsTr("C")
        Layout.column: 3
        Layout.row: 2

        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true

        ToolTip.text: "Clear (esc)"
        hoverEnabled: true
        ToolTip.visible: hovered

        onClicked: {
            memo.text = "0"
            resultDisplay.text = ""
        }
    }

    Button {
        id: buttonBackSpace
        text: qsTr("<-")
        Layout.column: 4
        Layout.row: 2

        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.text = resultDisplay.text.substring(0, resultDisplay.length - 1)
        }
        ToolTip.text: "(backspace)"
        hoverEnabled: true
        ToolTip.visible: hovered
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
        id: buttonEquals
        text: qsTr("=")
        Layout.column: 4
        Layout.row: 5
        Layout.rowSpan: 2

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: evaluateSignal(qsTr(resultDisplay.text))

        ToolTip.text: "Evaluate expression (return) or (enter)"
        hoverEnabled: true
        ToolTip.visible: hovered
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

        Layout.column: 3
        Layout.row: 6

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            insertOperator("-")
        }
    }
}
