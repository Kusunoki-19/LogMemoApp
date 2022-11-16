import QtQuick
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

import Qt.labs.settings

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
        let year   = parseInt(currentTime.toLocaleString(locale, "yyyy"))
        let month  = parseInt(currentTime.toLocaleString(locale, "MM"  ))
        let day    = parseInt(currentTime.toLocaleString(locale, "dd"  ))
        let hour   = parseInt(currentTime.toLocaleString(locale, "hh"  ))
        let min    = parseInt(currentTime.toLocaleString(locale, "mm"  ))
        inputYear   .text = year
        inputMonth  .text = month
        inputDay    .text = day
        inputHour   .text = hour
        inputMin    .text = min
    }

    Component.onCompleted: {
        const locale = Qt.locale()
        const currentTime = new Date()
        inputYear   .text = settings.value("yyyy", parseInt(currentTime.toLocaleString(locale, "yyyy")))
        inputMonth  .text = settings.value("MM"  , parseInt(currentTime.toLocaleString(locale, "MM"  )))
        inputDay    .text = settings.value("dd"  , parseInt(currentTime.toLocaleString(locale, "dd"  )))
        inputHour   .text = settings.value("hh"  , parseInt(currentTime.toLocaleString(locale, "hh"  )))
        inputMin    .text = settings.value("mm"  , parseInt(currentTime.toLocaleString(locale, "mm"  )))
    }

    Component.onDestruction: {
        settings.saveCurrentInput()
    }

    Settings {
        id:settings

        function saveCurrentInput() {
            settings.setValue("yyyy", parseInt(inputYear .text))
            settings.setValue("MM"  , parseInt(inputMonth.text))
            settings.setValue("dd"  , parseInt(inputDay  .text))
            settings.setValue("hh"  , parseInt(inputHour .text))
            settings.setValue("mm"  , parseInt(inputMin  .text))
        }
    }

    Button {
        id:nowSetButton
        text: "Now"
        visible:!root.autoSetMode
        Layout.preferredWidth: 50
        onClicked: {
            root.setToCurrent()
        }
    }

    Item {
        visible:root.autoSetMode
        Layout.preferredWidth: 50
        Label {
            anchors.centerIn: parent
            text:"[Now]"
            Timer {
                interval: 1000*5; running:parent.visible; repeat:true
                onTriggered: root.setToCurrent()
            }
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
