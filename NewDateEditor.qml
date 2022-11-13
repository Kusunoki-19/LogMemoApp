import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

Item {
    id:root
    width:dataInputArea.width
    height:dataInputArea.height

    function getMapObject () {
        let mapObj =  {
            "year"  : parseInt(inputYear.text  ),
            "month" : parseInt(inputMonth.text ),
            "day"   : parseInt(inputDay.text   ),
            "hour"  : parseInt(inputHour.text  ),
            "min"   : parseInt(inputMin.text   ),
        }
        console.log("year  , ", mapObj.year     )
        console.log("month , ", mapObj.month    )
        console.log("day   , ", mapObj.day      )
        console.log("hour  , ", mapObj.hour     )
        console.log("min   , ", mapObj.min      )

        return mapObj
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

            Label { text: "New Date" }

            Button {
                text: "set to current"
                onClicked: {
                    root.setToCurrent()
                }
            }
        }

        Grid {
            columns:5
            rows:2
            flow:Grid.TopToBottom

            Label { text: "year" }
            TextField {
                id: inputYear;
                validator: IntValidator{bottom: 0; top: 9999;}
            }

            Label { text: "month" }
            TextField {
                id: inputMonth;
                validator: IntValidator{bottom: 1; top: 12;}
            }

            Label { text: "day" }
            TextField {
                id: inputDay;
                validator: IntValidator{bottom: 1; top: 31;}
            }

            Label { text: "hour" }
            TextField {
                id: inputHour;
                validator: IntValidator{bottom: 0; top: 23;}
            }

            Label { text: "min" }
            TextField {
                id: inputMin;
                validator: IntValidator{bottom: 0; top: 59;}
            }
        }
    }
}
