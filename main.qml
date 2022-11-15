import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

import "RecordGUI" as RecordGUI
import "RecordGUI/DateGUI" as DateGUI
import "RecordGUI/SubjectGUI" as SubjectGUI

ApplicationWindow {
    id:window
    visible: true

    Material.theme: Material.Dark
    Material.accent: Material.Purple

    Column{
        anchors.fill: parent
        Row {
            id:menu
            width:parent.width
            Button {
                text:"Add Record"
                onClicked :{
                    views.x = Qt.binding(function(){return -pageAddRecord.x})
                }

            }
            Button {
                text:"Time Sheet"
                onClicked :{
                    views.x = Qt.binding(function(){return -pageTimeSheet.x})
                }
            }
            Button {
                text:"Statics"
                onClicked :{
                    views.x = Qt.binding(function(){return -pageStatics.x})
                }
            }
        }
        Item {
            id:contentFrame
            width:parent.width
            height:parent.height - menu.height
            Row {
                id:views
                height:parent.height
                Item {
                    id:pageAddRecord
                    width:contentFrame.width
                    height:contentFrame.height
                    AddRecordPage {
                        id: recordCreatorAndViewer
                        anchors.fill: parent
                    }
                }
                Item {
                    id:pageTimeSheet
                    width:contentFrame.width
                    height:contentFrame.height
                }
                Item {
                    id:pageStatics
                    width:contentFrame.width
                    height:contentFrame.height
                }
            }
        }

    }
}
