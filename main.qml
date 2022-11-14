import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

import "RecordGUI" as RecordGUI
import "RecordGUI/DateGUI" as DateGUI
import "RecordGUI/SubjectGUI" as SubjectGUI

ApplicationWindow {
    width: recordCreatorAndViewer.width
    height: 480
    visible: true
    title: qsTr("Hello World")

    Material.theme: Material.Dark
    Material.accent: Material.Purple

    Flickable {
        anchors.fill:parent
        contentWidth: recordCreatorAndViewer.width
        contentHeight: recordCreatorAndViewer.height
        Column {
            id:recordCreatorAndViewer

            RecordGUI.Creator {
            }

            Column {
                Repeater {
                    model:DataStorage.records
                    delegate: RecordGUI.Viewer {
                        record:modelData
                    }
                }
            }
        }

    }

}
