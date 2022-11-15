import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

import "RecordGUI" as RecordGUI
import "RecordGUI/DateGUI" as DateGUI
import "RecordGUI/SubjectGUI" as SubjectGUI

Column{
    id:recordCreatorAndViewer
    RecordGUI.Creator {
        id:recordCreator
        width:parent.width
    }
    ListView {
        id:recordList
        width:parent.width
        height:parent.height - recordCreator.height
        model:DataStorage.records.reverse()

        delegate: RecordGUI.Viewer {
            record:modelData
            recordIndex:(DataStorage.records.length-1) - index
            width: recordList.width
        }
    }
}
