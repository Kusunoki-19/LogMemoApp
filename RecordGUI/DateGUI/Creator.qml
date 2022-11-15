import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

RowLayout{
    id:root
    width:parent.width
    height:50

    readonly property int year  : parseInt(inputYear.text  )
    readonly property int month : parseInt(inputMonth.text )
    readonly property int day   : parseInt(inputDay.text   )
    readonly property int hour  : parseInt(inputHour.text  )
    readonly property int min   : parseInt(inputMin.text   )
    readonly property var dateObject : {
        "year"  : year  ,
        "month" : month ,
        "day"   : day   ,
        "hour"  : hour  ,
        "min"   : min   ,
    }

    function setToCurrent() {
        let locale = Qt.locale()
        let currentTime = new Date()
        inputYear   .text = parseInt(currentTime.toLocaleString(locale, "yyyy"))
        inputMonth  .text = parseInt(currentTime.toLocaleString(locale, "MM"))
        inputDay    .text = parseInt(currentTime.toLocaleString(locale, "dd"))
        inputHour   .text = parseInt(currentTime.toLocaleString(locale, "hh"))
        inputMin    .text = parseInt(currentTime.toLocaleString(locale, "mm"))
    }

    Component.onCompleted: setToCurrent()


    Button {
        text: "Set by current time"
        Layout.fillWidth: true
        Layout.fillHeight: true
        onClicked: {
            root.setToCurrent()
        }
    }
    TextField {
        id: inputYear;
        Layout.fillWidth: true
        Layout.fillHeight: true
        placeholderText: "YYYY"
        validator: IntValidator{bottom: 0; top: 9999;}
    }
    TextField {
        id: inputMonth;
        Layout.fillWidth: true
        Layout.fillHeight: true
        placeholderText: "MM"
        validator: IntValidator{bottom: 1; top: 12;}
    }
    TextField {
        id: inputDay;
        Layout.fillWidth: true
        Layout.fillHeight: true
        placeholderText: "dd"
        validator: IntValidator{bottom: 1; top: 31;}
    }
    TextField {
        id: inputHour;
        Layout.fillWidth: true
        Layout.fillHeight: true
        placeholderText: "hh"
        validator: IntValidator{bottom: 0; top: 23;}
    }
    TextField {
        id: inputMin;
        Layout.fillWidth: true
        Layout.fillHeight: true
        placeholderText:"mm"
        validator: IntValidator{bottom: 0; top: 59;}
    }
}
