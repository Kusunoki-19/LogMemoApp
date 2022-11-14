import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

Item {
    id:root
    width:dataInputArea.width
    height:dataInputArea.height
    property string title : "New Date"
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

    Column{
        id:dataInputArea

        Grid {
            columns:2
            rows:1
            spacing:10
            verticalItemAlignment: Grid.AlignVCenter
            Label { text: root.title }
        }

        Grid {
            rows:1
            verticalItemAlignment:Grid.AlignVCenter
            Button {
                text: "Set by current time"
                onClicked: {
                    root.setToCurrent()
                }
            }
            TextField {
                id: inputYear;
                placeholderText: "YYYY"
                validator: IntValidator{bottom: 0; top: 9999;}
            }
            TextField {
                id: inputMonth;
                placeholderText: "MM"
                validator: IntValidator{bottom: 1; top: 12;}
            }
            TextField {
                id: inputDay;
                placeholderText: "dd"
                validator: IntValidator{bottom: 1; top: 31;}
            }
            TextField {
                id: inputHour;
                placeholderText: "hh"
                validator: IntValidator{bottom: 0; top: 23;}
            }
            TextField {
                id: inputMin;
                placeholderText:"mm"
                validator: IntValidator{bottom: 0; top: 59;}
            }
        }
    }
}
