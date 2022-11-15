import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

import "RecordGUI" as RecordGUI
import "RecordGUI/DateGUI" as DateGUI
import "RecordGUI/SubjectGUI" as SubjectGUI

Item {
    id: root
    property int day

    Repeater {
        model:24
        delegate: Item {
            y: root.height / (24*60) * (modelData*60)
            ToolSeparator{
                width:root.width
                anchors.verticalCenter: parent.verticalCenter
                orientation:Qt.Horizontal
            }
            Label { text:modelData+ ":00" }
        }
    }

    ListView {
        clip:true
        anchors.fill: parent
        orientation:ListView.Horizontal

        displayMarginBeginning:width
        displayMarginEnd:width

        snapMode:ListView.SnapOneItem
        property int day : root.day

        model:[
            this.day-7,
            this.day-6,
            this.day-5,
            this.day-4,
            this.day-3,
            this.day-2,
            this.day-1,
            this.day
        ]
        Component.onCompleted: positionViewAtIndex(this.model.length - 1, ListView.Beginning )
        delegate: Item {
            width:ListView.view.width
            height:ListView.view.height
            ToolSeparator {
                anchors.right: parent.right
                height:parent.height
            }
            Item {
                id: dayRecordsContainer
                width:parent.width - 60
                height:parent.height
                x:50
                property int day : modelData

                Repeater {
                    model:DataStorage.records.filter(record => (record.startDate.day === dayRecordsContainer.day))
                    delegate: Pane {
                        property int recordStartMin : (modelData.startDate.hour) * 60 + (modelData.startDate.min)
                        property int recordMinDuration : (modelData.endDate.hour - modelData.startDate.hour) * 60 + (modelData.endDate.min - modelData.startDate.min)
                        width: dayRecordsContainer.width
                        height: dayRecordsContainer.height / (24*60) * recordMinDuration
                        y: dayRecordsContainer.height / (24*60) * recordStartMin
                        Material.background : Material.Lime
                        Material.elevation : 6
                        Column{
                            Label {
                                text:modelData.subject.name + " ("+modelData.subject.category+")"
                                color:Material.color(Material.Lime, Material.Shade900)
                            }
                        }
                    }
                }

                Label {
                    anchors.right: parent.right
                    text: "Day:" + dayRecordsContainer.day
                    font.bold: true
                    background:Rectangle{ color:Material.color(Material.Grey, Material.Shade900) }
                }
            }
        }
    }

}
