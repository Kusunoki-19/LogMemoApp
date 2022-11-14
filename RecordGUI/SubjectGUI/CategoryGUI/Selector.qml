import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0


ComboBox {
    id:control
    width:parent.width

    readonly property string currentCategory : currentValue !== undefined ? currentValue : ""
    readonly property var subjectAndLastEmptyOne : DataStorage.categories.concat("---")

    model: subjectAndLastEmptyOne

    displayText: {
        return "category: " + currentCategory
    }

    delegate: ItemDelegate {
        required property int index
        required property var modelData
        readonly property bool isLastElement : (index === (control.model.length - 1))

        implicitWidth:control.width

        text: {
            if (isLastElement) {
                return "+ Add New Category..."
            }
            else {
                return index + " category: " + modelData
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
        onAddedCategory: {
            control.currentIndex = (control.model.length - 2)
        }
    }
}
