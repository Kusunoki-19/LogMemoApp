import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

Pane {
    id:root
    property var record
    contentWidth:viewer.width
    contentHeight:viewer.height
    Column {
        id:viewer
        SubjectViewer {
            subject: root.record.subject
        }

        DateViewer {
            title : "start date"
            date: root.record.startDate
        }

        DateViewer {
            title : "end date"
            date: root.record.endDate
        }
    }

}

