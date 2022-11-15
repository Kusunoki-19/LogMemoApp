import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

import "DateGUI" as DateGUI
import "SubjectGUI" as SubjectGUI

Pane {
    id:root
    property var record
    property int recordIndex
    contentHeight: viewer.height

    Column {
        id:viewer
        width:parent.width

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

    Button {
        text:root.recordIndex
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onClicked: {
            DataStorage.removeRecord(root.recordIndex)
        }
    }
}

