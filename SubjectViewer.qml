import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

Column {
    id: root
    property var subject
    Label { text: "Subject" }
    Row {
        Label { text: "name: "}
        Label { text: root.subject.name }
    }
    Row {
        Label { text: "category: "}
        Label { text: root.subject.category }
    }
}
