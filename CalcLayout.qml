import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4

GridLayout {
    id: "mgrid"
    anchors.fill: parent
    anchors.margins: 0

    rowSpacing: 1
    columnSpacing: 1

    columns: 6
    rows: 5
    property double colMulti : mgrid.width / mgrid.columns
    property double rowMulti : mgrid.height / mgrid.rows

    function prefWidth(item){
        return colMulti * item.Layout.columnSpan
    }

    function prefHeight(item){
        return rowMulti * item.Layout.rowSpan
    }

    property var validatorRegExp: /^(([(]|s[(])*)(([0-9]+)|([0-9]+\.[0-9]))(?:([-+*\/\^])(([(]|s[(])*)((([0-9]+)|([0-9]+\.[0-9]+))([)]*)))+$/

    function setResult (arg) {
        resultDisplay.text = arg
    }

    function insertOperator (arg) {
        var patt = /^.*[\.\+\-\*/\^(s\()]$/;

        if (patt.test(resultDisplay.text)) {
            var len = 1
            resultDisplay.text = resultDisplay.text.substring(0, resultDisplay.length - len) + arg
        }
        else if (resultDisplay.text != "")
            resultDisplay.text += arg
        var possibleResult = resultDisplay.text + arg


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
        case Qt.Key_Menu:
            if (memo.text.charAt(0) === "-")
                memo.text = memo.text.substring(1);
            else if(/[0-9]/.test(memo.text.charAt(0)))
                memo.text = '-' + memo.text;
            break
        }
    }

    TextField {
        id: resultDisplay
        objectName: qsTr("resultDisplay")

        focus: true
        placeholderText: qsTr("0")
        horizontalAlignment: TextInput.AlignRight
        font.pixelSize: 45

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

        text: qsTr("0")

        Layout.column: 0
        Layout.row: 1
        Layout.columnSpan: 5

        Layout.minimumHeight: 90
        Layout.fillWidth: true

        horizontalAlignment: Text.AlignRight
        font.pixelSize: 65

        onTextChanged: {
            if(/[0-9]+|[0-9]+\.[0-9]+/.test(memo.text)) {
                buttonMS.enabled = true;
                buttonReverse.enabled = true;
            } else {
                buttonMS.enabled = false;
                buttonReverse.enabled = false;
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

        Layout.preferredWidth  : mgrid.prefWidth(this)
        Layout.preferredHeight : mgrid.prefHeight(this)

        background: Rectangle {
            color: buttonMS.down ? "#B0BEC5" : "#CFD8DC"
        }

        font.pixelSize: 30
        flat: true

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

        Layout.preferredWidth  : mgrid.prefWidth(this)
        Layout.preferredHeight : mgrid.prefHeight(this)

        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true

        background: Rectangle {
            color: buttonMR.down ? "#B0BEC5" : "#CFD8DC"
        }

        font.pixelSize: 30
        flat: true

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


        Layout.preferredWidth  : mgrid.prefWidth(this)
        Layout.preferredHeight : mgrid.prefHeight(this)
        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true

        background: Rectangle {
            color: buttonMplus.down ? "#B0BEC5" : "#CFD8DC"
        }

        font.pixelSize: 30
        flat: true

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


        Layout.preferredWidth  : mgrid.prefWidth(this)
        Layout.preferredHeight : mgrid.prefHeight(this)
        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true

        background: Rectangle {
            color: buttonClear.down ? "#B0BEC5" : "#CFD8DC"
        }

        font.pixelSize: 30
        flat: true

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
        text: qsTr("⌫")
        Layout.column: 4
        Layout.row: 2


        Layout.preferredWidth  : mgrid.prefWidth(this)
        Layout.preferredHeight : mgrid.prefHeight(this)
        Layout.maximumHeight: 48
        Layout.fillHeight: true
        Layout.fillWidth: true

        background: Rectangle {
            color: buttonBackSpace.down ? "#B0BEC5" : "#CFD8DC"
        }

        font.pixelSize: 30
        flat: true

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

        background: Rectangle {
            color: button7.down ? "#90A4AE" : "#B0BEC5"
        }
        font.pixelSize: 30
        flat: true

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

        background: Rectangle {
            color: button8.down ? "#90A4AE" : "#B0BEC5"
        }
        font.pixelSize: 30
        flat: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: button9
        text: qsTr("9")
        Layout.column: 2
        Layout.row: 3

        background: Rectangle {
            color: button9.down ? "#90A4AE" : "#B0BEC5"
        }
        Layout.fillHeight: true
        Layout.fillWidth: true

        font.pixelSize: 30
        flat: true

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
            resultDisplay.insert(resultDisplay.text.length, "(")
        }
        background: Rectangle {
            color: buttonLeftBracket.down ? "#B0BEC5" : "#CFD8DC"
        }

        font.pixelSize: 30
        flat: true

    }

    Button {
        id: buttonRightBracket
        text: qsTr(")")
        Layout.column: 4
        Layout.row: 3

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.insert(resultDisplay.text.length, ")")
        }
        background: Rectangle {
            color: buttonRightBracket.down ? "#B0BEC5" : "#CFD8DC"
        }

        font.pixelSize: 30
        flat: true
    }

    Button {
        id: button4
        text: qsTr("4")
        Layout.column: 0
        Layout.row: 4

        background: Rectangle {
            color: button4.down ? "#90A4AE" : "#B0BEC5"
        }
        Layout.fillHeight: true
        Layout.fillWidth: true

        font.pixelSize: 30
        flat: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: button5
        text: qsTr("5")
        Layout.column: 1
        Layout.row: 4

        background: Rectangle {
            color: button5.down ? "#90A4AE" : "#B0BEC5"
        }
        Layout.fillHeight: true
        Layout.fillWidth: true

        font.pixelSize: 30
        flat: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: button6
        text: qsTr("6")
        Layout.column: 2
        Layout.row: 4

        background: Rectangle {
            color: button6.down ? "#90A4AE" : "#B0BEC5"
        }
        Layout.fillHeight: true
        Layout.fillWidth: true

        font.pixelSize: 30
        flat: true

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
            resultDisplay.insert(resultDisplay.text.length, "*")
        }
        background: Rectangle {
            color: buttonMul.down ? "#B0BEC5" : "#CFD8DC"
        }

        font.pixelSize: 30
        flat: true
    }

    Button {
        id: buttonDiv
        text: qsTr("÷")
        Layout.column: 4
        Layout.row: 4

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.insert(resultDisplay.text.length, "/")
        }
        background: Rectangle {
            color: buttonDiv.down ? "#B0BEC5" : "#CFD8DC"
        }

        font.pixelSize: 30
        flat: true
    }

    Button {
        id: button1
        text: qsTr("1")
        Layout.column: 0
        Layout.row: 5

        background: Rectangle {
            color: button1.down ? "#90A4AE" : "#B0BEC5"
        }
        Layout.fillHeight: true
        Layout.fillWidth: true

        font.pixelSize: 30
        flat: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: button2
        text: qsTr("2")
        Layout.column: 1
        Layout.row: 5

        background: Rectangle {
            color: button2.down ? "#90A4AE" : "#B0BEC5"
        }
        Layout.fillHeight: true
        Layout.fillWidth: true

        font.pixelSize: 30
        flat: true

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

        background: Rectangle {
            color: button3.down ? "#90A4AE" : "#B0BEC5"
        }
        font.pixelSize: 30
        flat: true

        onClicked: {
            resultDisplay.text = resultDisplay.text + this.text
        }
    }

    Button {
        id: buttonEquals
        text: qsTr("=")
        Layout.column: 0
        Layout.row: 7
        Layout.columnSpan: 5

        Layout.fillWidth: true

        onClicked: evaluateSignal(qsTr(resultDisplay.text))

        ToolTip.text: "Evaluate expression (return) or (enter)"
        hoverEnabled: true
        ToolTip.visible: hovered

        background: Rectangle {
            color: buttonEquals.down ? "#546E7A" : "#607D8B"
        }

        font.pixelSize: 30
        flat: true
    }

    Button {
        id: buttonReverse
        text: qsTr("±")
        Layout.column: 0
        Layout.row: 6

        hoverEnabled: true
        ToolTip.visible: hovered
        Layout.fillHeight: true
        Layout.fillWidth: true

        background: Rectangle {
            color: buttonReverse.down ? "#90A4AE" : "#B0BEC5"
        }
        font.pixelSize: 30
        flat: true

        onClicked: {
            if (memo.text.charAt(0) === "-")
                memo.text = memo.text.substring(1);
            else if(/[0-9]/.test(memo.text.charAt(0)))
                memo.text = '-' + memo.text;
        }
        ToolTip.text: "Change sign (menu)"
    }

    Button {
        id: button0
        text: qsTr("0")
        Layout.column: 1
        Layout.row: 6

        Layout.fillHeight: true
        Layout.fillWidth: true

        background: Rectangle {
            color: button0.down ? "#90A4AE" : "#B0BEC5"
        }
        font.pixelSize: 30
        flat: true

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

        background: Rectangle {
            color: buttonPoint.down ? "#90A4AE" : "#B0BEC5"
        }
        font.pixelSize: 30
        flat: true

        onClicked: {
            resultDisplay.insert(resultDisplay.text.length, ".")
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
            resultDisplay.insert(resultDisplay.text.length, '+')
        }

        background: Rectangle {
            color: buttonPlus.down ? "#B0BEC5" : "#CFD8DC"
        }

        font.pixelSize: 30
        flat: true
    }

    Button {
        id: buttonPow
        text: qsTr("^")
        Layout.column: 4
        Layout.row: 5

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.insert(resultDisplay.text.length, '^')
        }
        background: Rectangle {
            color: buttonPow.down ? "#B0BEC5" : "#CFD8DC"
        }

        font.pixelSize: 30
        flat: true
    }

    Button {
        id: buttonSqrt
        text: qsTr("√")
        Layout.column: 4
        Layout.row: 6

        Layout.fillHeight: true
        Layout.fillWidth: true

        hoverEnabled: true
        ToolTip.visible: hovered
        onClicked: {
            resultDisplay.insert(resultDisplay.text.length, 's(');
        }
        background: Rectangle {
            color: buttonSqrt.down ? "#B0BEC5" : "#CFD8DC"
        }

        font.pixelSize: 30
        flat: true
        ToolTip.text: "Square root (s()"
    }

    Button {
        id: buttonMinus
        text: qsTr("−")

        Layout.column: 3
        Layout.row: 6

        Layout.fillHeight: true
        Layout.fillWidth: true

        onClicked: {
            resultDisplay.insert(resultDisplay.text.length, '-')
        }
        background: Rectangle {
            color: buttonMinus.down ? "#B0BEC5" : "#CFD8DC"
        }

        font.pixelSize: 30
        flat: true
    }
}
