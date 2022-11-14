import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

import "DateGUI" as DateGUI
import "SubjectGUI" as SubjectGUI

Column {
    Label { text: "addRecord" }

    SubjectGUI.Selector {
        id:subjectSelector
        title : "subject"
    }

    DateGUI.Creator {
        id:startDateCreator
        title:"start"
    }

    DateGUI.Creator {
        id:endDateCreator
        title:"end"
    }

    Button {
        text:"submit"
        onClicked: {
            DataStorage.addRecord(subjectSelector.subjectObject, startDateCreator.dateObject, endDateCreator.dateObject)
        }
    }
}
