import QtQuick 2.0
Rectangle{
    id: recommend
    objectName: "recommend"
    width: 155 * 5
    height: 680
    color: "#fff"
    signal playlistClickSignal(var id)
    /*
    ListModel {
        id: data
    }
    ListView {
        id: list
        anchors.fill: parent
        Component {
            id: aitem
            Rectangle {
                width: 141
                height: 141 + 30
                Text {
                    text: content
                }
            }
        }
        model: data
        delegate: aitem
    }*/
    ListModel {
        id: data
    }

    GridView {
        anchors.fill: parent
        id: grids
        cellHeight: 213
        cellWidth: 155
        Component {
            id: aitem
            Rectangle {
                width: 139
                height: 169 + 8
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: recommend.playlistClickSignal(id.toString())
                }
                Rectangle{
                    width: 139
                    height: 139
                    border {
                        color: "#A1A1A2"
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
