import QtQuick
import DataComponents 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    DataCell{
        id: testDataCell

    }

    Column {
        Text {
            text: "type:" + testDataCell.type
        }
        Text {
            text: "byteSize:" + testDataCell.byteSize
        }
        Text {
            text: "value:" + testDataCell.value
        }
    }
}
