import QtQuick 2.0

Rectangle {
    width: 200
    height: 60
    property string imgUrl: ""
    property string title: "牛仔很忙"
    property string singer: "伦伦"
    Rectangle {
        border.color: "#e1e1e2"
        border.width: 1
        color: "#f5f5f7"
        anchors.fill: parent
        Image {
            source: imgUrl
            width: 44
            height: 44
            x: 6
            y: 8
        }
        Rectangle  {
            width: 141
            height: 16
            x: 56
            y: 14
            color: "#f5f5f7"
            Text {
                text: title
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                elide: Qt.ElideRight
                font.family: "Arial, Helvetica, sans-serif"
            }
        }
        Rectangle {
            width: 141
            height: 16
            x: 56
            y: 30
            color: "#f5f5f7"
            Text {
                text: singer
                color: "#7c6693"
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                elide: Qt.ElideRight
                font.family: "Arial, Helvetica, sans-serif"
            }
        }
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }

    }
    function freshen (res) {
        imgUrl = res["songs"][0].al.picUrl
        title = res["songs"][0].name
        singer = res["songs"][0].ar[0].name
    }
}
