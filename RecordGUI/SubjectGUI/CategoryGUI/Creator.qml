import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

Popup {
    id: root

    signal addedCategory

    contentItem : Column {
        Label { text: "New Category" }
        Grid {
            columns:1
            verticalItemAlignment:Grid.AlignVCenter

            Label { text: "category" }
            TextField { id: inputSubjectCategory }

            Button {
                text:"Add"
                onClicked : {
                    DataStorage.addCategory(inputSubjectCategory.text)
                    root.close()
                    root.addedCategory()
                }
            }
        }
    }
}
