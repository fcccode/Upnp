import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import MyComponents 1.0

ColumnLayout {
    id: item

    property var device
    property int rootIndex
    property string rootIconUrl

    Row {
        anchors { left: parent.left; leftMargin: 10; right: parent.right; rightMargin: 10 }
        height: backButton.height + 20
        Layout.preferredHeight: height
        spacing: 10

        MyButton {
            id: backButton
            anchors { verticalCenter: parent.verticalCenter }
            sourceComponent: Text { id: text; text: "< Back" }
            onButtonClicked: setRootDeviceDetails(rootIndex, rootIconUrl)
        }

        Image {
            anchors { verticalCenter: parent.verticalCenter }
            width: parent.height*0.9
            height: width
            sourceSize.width: width
            sourceSize.height: width
            fillMode: Image.PreserveAspectFit
            source: rootIconUrl
        }

        Text {
            width: contentWidth
            anchors.verticalCenter: parent.verticalCenter
            text: device.deviceType
            clip: true
        }
    }

    TabBar {
        id: tabBar
        Layout.fillWidth: true
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Description")
        }
        TabButton {
            text: qsTr("Devices")
        }
        TabButton {
            text: qsTr("Services")
        }
    }

    SwipeView {
        id: swipeView
        Layout.fillWidth: true
        Layout.fillHeight: true
        currentIndex: tabBar.currentIndex

        Flickable {
            id: flickable

            TextArea.flickable: TextArea {
                text: item.device.description
                wrapMode: TextArea.Wrap
            }

            ScrollBar.vertical: ScrollBar { }
        }

        ListView {
            id: devicesView

            ScrollBar.vertical: ScrollBar { }

            model: item.device.devicesModel

            delegate: DeviceDelegate { }

            clip: true

            function selectDevice(index) {
                setDeviceDetails(item.device.devicesModel.at(index), item.rootIndex, item.iconurl)
            }
        }

        ListView {
            id: servicesView

            ScrollBar.vertical: ScrollBar { }

            model: item.device.servicesModel

            delegate: ServiceDelegate { }

            clip: true

            function selectService(index) {
                setServiceDetails(item.device.servicesModel.at(index), item.rootIndex, item.iconurl)
            }
        }
    }
}

