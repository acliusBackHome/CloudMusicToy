import QtQuick 2.0
import QtQuick.Controls 2.2
Rectangle {
    id: listpop
    width: 580
    height: 477
    signal pieceClickSignal(var sid)
    signal clearListSignal()
    property real listNums: 0
    Rectangle {
        color: "#ccc"
        anchors.fill: parent
        Rectangle {
            x: 2
            y: 2
            width: parent.width - 2
            height: parent.height - 2
            Rectangle {
                id: listT
                width: parent.width
                height: 41
                color: "#f2f1f4"
                border.width: 1
                border.color: "#f2f1f4"
                Rectangle {
                    width: 100
                    height: 26
                    radius: 4
                    color: "#7c7d85"
                    anchors.centerIn: parent
                    Text {
                        color: "#fff"
                        text: "播放列表"
                        font.family: "Arial, Helvetica, sans-serif"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
            Rectangle {
                id: listNL
                width: parent.width
                height: 30
                anchors.top: listT.bottom
                Text {
                    anchors.leftMargin: 30
                    text: "共" + listNums + "首"
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial, Helvetica, sans-serif"
                }
                Text {
                    width: 141
                    height: 30
                    text: "清空"
                    font.family: "Arial, Helvetica, sans-serif"
                    x: parent.width - width
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    MouseArea {
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                        onClicked: clearListSignal()
                    }
                }
            }
            Rectangle {
                id: listContainer
                width: parent.width
                height: parent.height - listT.height -listNL.height
                anchors.top: listNL.bottom
                clip: true
                Component {
                    id: ait
                    Rectangle {
                        width: parent.width
                        height: 30
                        color: num % 2 ? "#fafafa" : "#f5f5f7"
                        Text {
                            width: 330
                            height: 30
                            text: title
                            x: 30
                            color: "#333"
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial, Helvetica, sans-serif"
                        }
                        Text {
                            x: 30 + 330
                            width: 130
                            text: singer
                            height: 30
                            color: "#8b8b8b"
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial, Helvetica, sans-serif"
                        }
                        Text {
                            x: 30 + 330 + 130
                            text: time
                            height: 30
                            color: "#707070"
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial, Helvetica, sans-serif"
                        }
                        MouseArea {
                            cursorShape: Qt.PointingHandCursor
                            anchors.fill: parent
                            onDoubleClicked: function () {
                                pieceClickSignal(sid)
                            }
                        }
                    }
                }
                ListModel {
                    id: listData
                }
                ListView {
                    anchors.fill: parent
                    model: listData
                    delegate: ait
                }
            }

        }
    }

   function normal(t) {
        var k = ~~(t / 1000)
        var a = ~~(k / 60)
        if (a < 10) a = "0" + a
        var b = k % 60
        if (b < 10) b = "0" + b
        return a + ":" + b
    }
    function createList (raw) {
        listNums = raw.length
        listData.clear()
        for (var i = raw.length - 1; i >= 0; i--) {
            var n = raw[i]
            console.log(n)
            listData.append({
                                num: i + 1,
                                sid: n[0],
                                title: n[1],
                                singer: n[2],
                                time: normal(n[3])
                            })
        }
    }
    function clear () {
        listData.clear()
    }

}
