import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

ComboBox {
    id:root
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

        text: {
            const lastModelIndex = (root.model.length - 1)
            if (index === lastModelIndex) {
                return "+ Add New Subject..."
            }
            else {
                return index +  " name: " + modelData.name + ", category: " + modelData.category
            }
        }

        onClicked : {
            const lastModelIndex = (root.model.length - 1)
            if (index === lastModelIndex) {
                newSubjectEditor.open()
            }
        }
    }
    NewSubjectEditor {
        id:newSubjectEditor
    }
}
