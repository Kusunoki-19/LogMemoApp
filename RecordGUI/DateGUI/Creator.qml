import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

RowLayout{
    id:root
    width:parent.width
    height:50
    property bool autoSetMode : false

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
        text: "Current"
        visible:!root.autoSetMode
        Layout.fillWidth: true
        Layout.fillHeight: true
        onClicked: {
            root.setToCurrent()
        }
    }
    Label {
        text:"[Now]"
        visible:root.autoSetMode
        Timer {
            interval: 1000*5; running:parent.visible; repeat:true
            onTriggered: root.setToCurrent()
        }
    }

    TextField {
        id: inputYear;
        Layout.fillWidth: true
        Layout.fillHeight: true
        placeholderText: "YYYY"
        enabled:!root.autoSetMode
        validator: IntValidator{bottom: 0; top: 9999;}
    }
    TextField {
        id: inputMonth;
        Layout.fillWidth: true
        Layout.fillHeight: true
        placeholderText: "MM"
        enabled:!root.autoSetMode
        validator: IntValidator{bottom: 1; top: 12;}
    }
    TextField {
        id: inputDay;
        Layout.fillWidth: true
        Layout.fillHeight: true
        placeholderText: "dd"
        enabled:!root.autoSetMode
        validator: IntValidator{bottom: 1; top: 31;}
    }
    TextField {
        id: inputHour;
        Layout.fillWidth: true
        Layout.fillHeight: true
        placeholderText: "hh"
        enabled:!root.autoSetMode
        validator: IntValidator{bottom: 0; top: 23;}
    }
    TextField {
        id: inputMin;
        Layout.fillWidth: true
        Layout.fillHeight: true
        placeholderText:"mm"
        enabled:!root.autoSetMode
        validator: IntValidator{bottom: 0; top: 59;}
    }
}
