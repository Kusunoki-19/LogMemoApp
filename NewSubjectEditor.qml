import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

Column {
    Label { text: "New Subject" }

    Row {
        Row {
            Label { text: "name" }
            TextField { id: inputSubjectName }
        }
        Row {
            Label { text: "category" }
            TextField { id: inputSubjectCategory }
        }
    }


    function getMapObject  () {
        return {
            name : inputSubjectName.text,
            category : inputSubjectCategory.text
        }
    }
}
