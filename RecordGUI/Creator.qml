import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

import "DateGUI" as DateGUI
import "SubjectGUI" as SubjectGUI

Column {
    Label {
        text:"select subject"
        width:parent.width
    }

    SubjectGUI.Selector {
        id:subjectSelector
        width:parent.width
    }

    Label {
        text:"start date"
        width:parent.width
    }

    DateGUI.Creator {
        id:startDateCreator
        width:parent.width
    }

    Label {
        text:"end date"
        width:parent.width
    }

    DateGUI.Creator {
        id:endDateCreator
        width:parent.width
        autoSetMode:true
    }

    Button {
        text:"submit"
        onClicked: {
            DataStorage.addRecord({"subject": subjectSelector.subjectObject, "startDate": startDateCreator.dateObject, "endDate": endDateCreator.dateObject})
            startDateCreator.setToCurrent()
        }
        width:parent.width
    }
}
