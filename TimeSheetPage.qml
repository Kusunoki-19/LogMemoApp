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

    Repeater {
        model:DataStorage.records.filter(record => (record.startDate.day === root.day))
        delegate: Pane {
            property int recordStartMin : (modelData.startDate.hour) * 60 + (modelData.startDate.min)
            property int recordMinDuration : (modelData.endDate.hour - modelData.startDate.hour) * 60 + (modelData.endDate.min - modelData.startDate.min)
            width: root.width
            height: root.height / (24*60) * recordMinDuration
            y: root.height / (24*60) * recordStartMin
            Material.background : Material.Lime
            Material.elevation : 6
            Column{
                Label {
                    text:modelData.subject.name
                    color:Material.color(Material.Lime, Material.Shade900)
                }
                Label {
                    text:modelData.subject.category
                    color:Material.color(Material.Lime, Material.Shade900)
                }
            }
        }
    }
}
