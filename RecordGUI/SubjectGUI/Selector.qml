import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

Column {
    id:root
    readonly property var subjectObject : { "name" : control.currentName, "category" : control.currentCategory}
    property string title : "Select Subject"

    width:parent.width

    Label {
        text: root.title
    }

    ComboBox {
        id:control
        width:parent.width
        readonly property var subjectAndLastEmptyOne : DataStorage.subjects.concat([{"name":"---", "category":"---" }])
        readonly property string currentName : currentValue !== undefined ? currentValue.name : ""
        readonly property string currentCategory : currentValue !== undefined ? currentValue.category : ""

        model: subjectAndLastEmptyOne
        displayText: {
            return "name: " + currentName + ", category: " + currentCategory
        }

        delegate: ItemDelegate {
            required property int index
            required property var modelData
            readonly property bool isLastElement : (index === (control.model.length - 1))

            implicitWidth:control.width

            text: {
                if (isLastElement) {
                    return "+ Add New Subject..."
                }
                else {
                    return index +  " name: " + modelData.name + ", category: " + modelData.category
                }
            }

            onClicked : {
                if (isLastElement) {
                    newSubjectEditor.open()
                }
            }
        }

        Creator {
            id:newSubjectEditor
            onAddedSubject: {
                control.currentIndex = (control.model.length - 2)
            }
        }
    }
}
