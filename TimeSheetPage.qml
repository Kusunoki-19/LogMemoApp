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
                    // 今日始まり or 今日終わりのレコードが対象.
                    model:DataStorage.records.filter(
                              record =>
                              (record.endDate.day === dayRecordsContainer.day)||
                              (record.startDate.day === dayRecordsContainer.day)
                              )
                    delegate: Pane {
                        id:pane

                        readonly property bool isYesterdayRecord :modelData.startDate.day === dayRecordsContainer.day - 1
                        readonly property bool isTomorrowRecord :modelData.endDate.day === dayRecordsContainer.day + 1

                        readonly property int startDateHour : (isYesterdayRecord) ?
                                                                    0 : modelData.startDate.hour
                        readonly property int startDateMin  : (isYesterdayRecord) ?
                                                                    0 : modelData.startDate.min

                        readonly property int endDateHour   : (isTomorrowRecord) ?
                                                                    24 : modelData.endDate.hour
                        readonly property int endDateMin    : (isTomorrowRecord) ?
                                                                    0  : modelData.endDate.min

                        readonly property int startMinOfDay : (startDateHour) * 60 +
                                                               (startDateMin)

                        readonly property int minDurationOfDay : (endDateHour - startDateHour) * 60 +
                                                                  (endDateMin - startDateMin)

                        readonly property int colorID : modelData.subject.color !== undefined ? modelData.subject.color : Material.Red

                        width: dayRecordsContainer.width

                        height: dayRecordsContainer.height / (24*60) * minDurationOfDay
                        y: dayRecordsContainer.height / (24*60) * startMinOfDay

                        Material.background : pane.colorID
                        Material.elevation : 6
                        Label {
                            text:modelData.subject.name + " ("+modelData.subject.category+")"
                            color:Material.color(pane.colorID, Material.Shade900)
                            anchors.verticalCenter: parent.verticalCenter
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
