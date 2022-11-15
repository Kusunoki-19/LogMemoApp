import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

ComboBox {
    id:control

    readonly property var subjectObject : { "name" : control.currentName, "category" : control.currentCategory}
    readonly property var subjectAndLastEmptyOne : DataStorage.subjects.concat([{"name":"---", "category":"---" }])
    readonly property string currentName : currentIndex !== undefined ? model[currentIndex].name : "undefined"
    readonly property string currentCategory : currentIndex !== undefined ? model[currentIndex].category : "undefined"

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
        implicitWidth:control.width
        onAddedSubject: {
            control.currentIndex = (control.model.length - 2)
        }
    }
}
