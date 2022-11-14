import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

Column {
    id: root
    property var date
    property string title : "Date"
    Label { text: root.title }
    Row {
        Label { text: root.date.year }
        Label { text: "/" }
        Label { text: root.date.month }
        Label { text: "/" }
        Label { text: root.date.day }
        Label { text: " " }
        Label { text: root.date.hour }
        Label { text: ":" }
        Label { text: root.date.min }
    }

}
