import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Material.theme: Material.Dark
    Material.accent: Material.Purple

    DataStorage {
        id: dataStorage
        onRecordsChanged: {
            console.log("onRecordsChanged : ", dataStorage.records.length)
        }
    }

    Flickable {
        anchors.fill:parent
        contentWidth: recordCreatorAndViewer.width
        contentHeight: recordCreatorAndViewer.height
        Column {
            id:recordCreatorAndViewer
            Column {
                Label { text: "addRecord" }

                NewSubjectEditor {
                    id:subjectEditor
                }

                NewDateEditor {
                    id:startDateEditor
                }

                NewDateEditor {
                    id:endDateEditor
                }

                Button {
                    text:"submit"
                    onClicked: {
                        dataStorage.addRecord(subjectEditor.getMapObject(), startDateEditor.getMapObject(), endDateEditor.getMapObject())
                    }
                }
            }

            Column {
                Repeater {
                    model:dataStorage.records
                    delegate: RecordViewer {
                        record:modelData
                    }
                }
            }
        }

    }

}
