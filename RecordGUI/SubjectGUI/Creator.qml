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
            ComboBox{
                id:inputSubjectColor
                model:[
                    Material.Red	,
                    Material.Pink	,
                    Material.Purple	,
                    Material.DeepPurple	,
                    Material.Indigo	,
                    Material.Blue	,
                    Material.LightBlue	,
                    Material.Cyan	,
                    Material.Teal	,
                    Material.Green	,
                    Material.LightGreen	,
                    Material.Lime	,
                    Material.Yellow	,
                    Material.Amber	,
                    Material.Orange	,
                    Material.DeepOrange	,
                    Material.Brown	,
                    Material.Grey	,
                    Material.BlueGrey
                ]
                delegate: ItemDelegate {
                    text:modelData
                    background:Rectangle{color: Material.color(modelData, Material.Shade100)}
                }
                Material.background: currentValue
                Material.foreground: currentValue
            }

            Button {
                text:"Add"
                onClicked : {
                    DataStorage.addSubject({
                                               "name" : inputSubjectName.text,
                                               "category" : inputSubjectCategory.currentCategory,
                                               "color" : inputSubjectColor.currentValue
                                           })
                    root.close()
                    root.addedSubject()
                }
            }
        }
    }
}
