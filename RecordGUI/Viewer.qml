import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

import "DateGUI" as DateGUI
import "SubjectGUI" as SubjectGUI
import "../CommonUI"

Pane {
    id:root
    property var record
    property int recordIndex
    contentHeight: viewer.height

    Column {
        id:viewer
        x:colorTie.width+colorTie.x+2
        width:parent.width -x

        SubjectGUI.Viewer {
            subject: root.record.subject
        }

        DateGUI.Viewer {
            title : "start date"
            date: root.record.startDate
        }

        DateGUI.Viewer {
            title : "end date"
            date: root.record.endDate
        }
    }

    ColorTie{
        id:colorTie
        colorID:root.record.subject.color !== undefined ? root.record.subject.color : Material.Red
    }

    Button {
        text:root.recordIndex
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onClicked: {
            DataStorage.removeRecord(root.recordIndex)
        }
    }
}

