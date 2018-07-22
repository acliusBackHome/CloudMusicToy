import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
Item {
    width: 1024 - 200
    height: 670 - 50 - 48
    id: listdetail
    signal songClickSignal(var sid)
    signal listClickSignal(var lid)
    property string bPicUrl: ""
    property string bTitleStr: ""
    property string creatorImgUrl: ""
    property string userNameStr: ""
    property string createDateStr: ""
    property string tagsStr: ""
    property string summaryStr: ""
    property string listId: ""
    property var listIds: new Array
    Component {
            id: topheader
            Rectangle {
                id: topcontainer
                width: parent.width
                height: 270 + 30 + 4 + 32
                color: "#fafafa"
                Rectangle {
                    id: top
                    width: parent.width
                    height: 270
                    color: "#fafafa"
                    Rectangle {
                        x: 30
                        y: 30
                        width: 200
                        height: 200
                        border {
                            color: "#efefef"
                            width: 1
                        }
                        Image {
                            x: 1
                            y: 1
                            id: bigpic
                            width: 198
                            height: 198
                            source: bPicUrl
                        }
                    }
                    Rectangle {
                        x: 254
                        y: 30
                        width: 535
                        Text {
                            id: bigtitle
                            width: parent.width
                            height: 30
                            font.pixelSize: 22
                            text: bTitleStr
                            font.weight: Font.ExtraLight
                            color: "#333"
                            font.family: '"Microsoft Yahei", Arial, Helvetica, sans-serif'
                        }
                        Row {
                            width: parent.width
                            height: 44
                            y: 35
                            spacing: 10
                            Rectangle {
                                width: 30
                                height: 30
                                radius: 30
                                anchors {
                                    verticalCenter: parent.verticalCenter
                                }
                                Image {
                                    id: creatorimg
                                    source: creatorImgUrl
                                    anchors.fill: parent
                                    visible: false
                                }
                                Rectangle {
                                    id: mask
                                    anchors.fill: parent
                                    radius: 15
                                    visible: false
                                }
                                OpacityMask {
                                    anchors.fill: creatorimg
                                    source: creatorimg
                                    maskSource: mask
                                }
                            }
                            Text {
                                id: username
                                text: userNameStr
                                font.family: "Arial, Helvetica, sans-serif"
                                anchors {
                                    verticalCenter: parent.verticalCenter
                                }
                            }
                            Text {
                                id: createDate
                                text: createDateStr
                                font.family: "Arial, Helvetica, sans-serif"
                                anchors {
                                    verticalCenter: parent.verticalCenter
                                }
                            }
                        }
                        Row {
                            width: parent.width
                            y: 84
                            spacing: 10
                            Rectangle {
                               id: playbtn
                               width: 120
                               height: 24
                               color: "#c62f2f"
                               radius: 4
                               Text {
                                   text: "播放全部"
                                   font.family: "Arial, Helvetica, sans-serif"
                                   color: "#fff"
                                   anchors.centerIn: parent
                               }
                               MouseArea {
                                   anchors.fill: parent
                                   cursorShape: Qt.PointingHandCursor
                                   onClicked: listdetail.listClickSignal(listIds)
                               }
                            }
                        }
                        Text {
                            id: tag
                            y: 130
                            width: parent.width
                            text: tagsStr
                            font.family: "Arial, Helvetica, sans-serif"
                        }
                        Text {
                            id: summary
                            y: 150
                            height: 41
                            width: parent.width
                            text: summaryStr
                            font.family: "Arial, Helvetica, sans-serif"
                            // wrapMode: Text.WrapAnywhere
                            clip: true
                            elide: Text.ElideRight
                            color: "#666"
                        }
                        Text {
                            width: 15
                            height: 15
                            anchors.top: summary.bottom
                            anchors.right: summary.right
                            rotation: 90
                            text: ">"
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                            }
                        }
                    }
                }
                Rectangle {
                     x: 70
                     width: 60
                     height: 30
                     id: alis
                     anchors.top: top.bottom
                     Text {
                         anchors.fill: parent
                         text: "歌曲列表"
                         color:"#c62f2f"
                         anchors.centerIn: parent
                         font.family: "Arial, Helvetica, sans-serif"
                         font.pixelSize: 15
                     }
                 }
                Rectangle {
                    id: alit
                    width: 60
                    height: 4
                    anchors.bottom: alis.bottom
                    anchors.left: alis.left
                    color: "#c62f2f"
                }
                Rectangle {
                    anchors.top: alit.bottom
                    width: parent.width
                    height: 32
                    color: "#e1e1e2"
                    id: aliu
                    Rectangle {
                        width: 50
                        height: 30
                        x: 0
                        y: 1
                        color: "#fafafa"
                    }
                    Rectangle {
                        width: 58
                        height: 30
                        x: 51
                        y: 1
                        color: "#fafafa"
                        Text {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            text: "操作"
                        }
                    }
                    Rectangle {
                        id: c3
                        width: 263
                        height: 30
                        x: 110
                        y: 1
                        color: "#fafafa"
                        Text {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            text: "音乐标题"
                        }
                    }
                    Rectangle {
                        width: 168
                        height: 30
                        x: 374
                        y: 1
                        color: "#fafafa"
                        Text {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            text: "歌手"
                        }
                    }
                    Rectangle {
                        width: 190
                        height: 30
                        x: 543
                        y: 1
                        color: "#fafafa"
                        Text {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            text: "专辑"
                        }
                    }
                    Rectangle {
                        width: 90
                        height: 30
                        x: parent.width - width
                        y: 1
                        color: "#fafafa"
                        Text {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            text: "时长"
                        }
                    }
                }
            }
        }
    Rectangle {
        clip: true
        anchors.fill: parent
        id: ali
        color: "#fafafa"
        ListModel {
            id: listdata
        }
        ListView {
            id: listview
            anchors.fill: parent
            header: topheader

            Component {
                id: atiem
                Rectangle {
                    height: 28
                    width: 815
                    // color: Control.hoverEnabled ? ("#ebeced") : (mid % 2 ? "#fff" : "#f5f5f7")
                    color: number % 2 ? "#fafafa" : "#f5f5f7"
                    // color: "#fff"
                    Rectangle {
                        width: 50
                        height: 28
                        color: "#00000000"
                        x: 0
                        Text {
                            text: number
                            anchors.fill: parent
                            anchors.rightMargin: 10
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    Rectangle {
                        width: 58
                        height: 28
                        x: 50
                        color: "#00000000"
                        Image {
                            x: 10
                            width: 24
                            height: 24
                            source: "qrc:///img/rdi_btn_love.png"
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    Rectangle {
                        width: 263
                        height: 28
                        x: 108
                        color: "#00000000"
                        Text {
                            text: title
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            elide: Qt.ElideRight
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    Rectangle {
                        width: 168
                        height: 28
                        x: 371
                        color: "#00000000"
                        Text {
                            text: singer
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            elide: Qt.ElideRight
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    Rectangle {
                        width: 181
                        height: 28
                        x: 543
                        color: "#00000000"
                        Text {
                            text: playlist
                            elide: Qt.ElideRight
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    Rectangle {
                        width: 90
                        height: 28
                        x: 733
                        color: "#00000000"
                        Text {
                            text: time
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onDoubleClicked: function () {
                            console.log(mid)
                            listdetail.songClickSignal(mid.toString())
                        }
                    }
                }
            }
            model: listdata
            delegate: atiem
        }
    }
    function nextTick (res) {
        console.log(res)
        bPicUrl = res.playlist.coverImgUrl
        bTitleStr = res.playlist.name
        creatorImgUrl = res.playlist.creator.avatarUrl
        createDateStr = (new Date(res.playlist.createTime)).toLocaleString() + "创建"
        userNameStr = res.playlist.creator.nickname
        listId = res.playlist.id
        var str = ""
        var tags = res.playlist.tags
        str = tags.join(" / ")
        tagsStr = "标签: " + str
        summaryStr = "简介: " + res.playlist.description
        var list = res.playlist.tracks
        listIds = []
        for (var i in list) {
            var a = list[i]
            listdata.append({
                                number: i * 1 + 1,
                                title: a.name,
                                singer: a.ar[0].name,
                                playlist: a.al.name,
                                time: ~~(a.dt / 1000 / 60) + ":" + ~~(a.dt / 1000) % 60,
                                mid: a.id.toString()
                            })
            listIds.push(a.id.toString())
        }
        // ali.height = 28 * list.length
    }
}
