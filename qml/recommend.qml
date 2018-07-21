import QtQuick 2.0
Rectangle {
    width: 1024 - 200
    height: 670 - 50 - 49
    color: "#fafafa"
    id: recommend
    objectName: "recommend"
    signal playlistClickSignal(var id)

    Component {
        id: title
        Rectangle {
            width: 155 * 5
            anchors.horizontalCenter: parent.horizontalCenter
            height: 41 + 10
            color: "#fafafa"

            Rectangle {
                width: 155 * 5
                height: 41

                color: "#e1e1e2"
                anchors.bottomMargin: 10
                Rectangle {
                    x: 0
                    y: 0
                    width: parent.width
                    height: 40
                    color: "#fafafa"
                    Text {
                        text: "推荐歌单"
                        font.pixelSize: 18
                        font.family: "Arial, Helvetica, sans-serif"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }

    Rectangle{
        width: 155 * 5
        height: parent.height
        color: "#fafafa"
        anchors.horizontalCenter: parent.horizontalCenter

        ListModel {
            id: data
        }

        GridView {
            anchors.fill: parent
            id: grids
            cellHeight: 213
            cellWidth: 155
            header: title
            Component {
                id: aitem
                Rectangle {
                    width: 139
                    height: 169 + 8
                    color: "#fafafa"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: recommend.playlistClickSignal(id.toString())
                    }
                    Rectangle{
                        width: 139
                        height: 139
                        border {
                            color: "#e5e5e5"
                            width: 1
                        }
                        Image {
                            y: 1
                            x: 1
                            width: 137
                            height: 137
                            source: picUrl
                        }
                    }
                    Text {
                        y: 139 + 8
                        width: 139
                        height: 30
                        text: content
                        font.family: "宋体"
                        font.pixelSize: 14
                        font.weight: Font.Light
                        wrapMode: Text.WordWrap
                    }
                }
            }
            model: data
            delegate: aitem
            }

    }
    function createItems (items) {
        console.log("init")
        items = items["result"]
        for (var i in items) {
            console.log(items[i]["name"])
            data.append({content: items[i]["name"],
                         picUrl: items[i]["picUrl"],
                         id: items[i]["id"]
                        })
        }
        return "hhh"
    }
}
