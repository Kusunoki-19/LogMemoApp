import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import DataComponents 1.0

Rectangle {
    property int colorID : Material.Red
    width:4
    x:2

    height:parent.height-20
    anchors.verticalCenter: parent.verticalCenter

    radius:this.height/2
    color:Material.color(colorID, Material.ShadeA100)

}
