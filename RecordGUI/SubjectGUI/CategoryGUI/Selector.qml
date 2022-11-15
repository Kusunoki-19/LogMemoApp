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
        id:delegateComponent
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

        Item {
            visible:!delegateComponent.isLastElement
            width:parent.height
            height:this.width
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            Button {
                width:parent.height - 5
                height:parent.height - 5
                anchors.centerIn: parent
                text:"x"
                onClicked : {
                    DataStorage.removeCategory(delegateComponent.index)
                }
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
