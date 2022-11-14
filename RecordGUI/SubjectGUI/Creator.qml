import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

import "CategoryGUI" as CategoryGUI

Popup {
    id: root

    signal addedSubject

    contentItem : Column {
        width: root.availableWidth

        Label {
            text: "New Subject"
        }

        Column {
            width:parent.width
            Label {
                text: "name"
            }
            TextField {
                id: inputSubjectName

            }
            CategoryGUI.Selector{
                id:inputSubjectCategory
            }
            Button {
                text:"Add"
                onClicked : {
                    DataStorage.addSubject({
                                               "name" : inputSubjectName.text,
                                               "category" : inputSubjectCategory.currentCategory
                                           })
                    root.close()
                    root.addedSubject()
                }
            }
        }
    }
}
