import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
Item {
    width: 815
    height: 1000
    id: listdetail
    signal songClickSignal(var sid)
    Rectangle {
        id: top
        width: 815
        height: 270
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
                source: ""
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
                text: ""
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
                        source: ""
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
                    text: "用户名"
                    font.family: "Arial, Helvetica, sans-serif"
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }
                }
                Text {
                    id: createDate
                    text: "创建"
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
                   }
                }
            }
            Text {
                id: tag
                y: 130
                width: parent.width
                text: "标签"
                font.family: "Arial, Helvetica, sans-serif"
            }
            Text {
                id: summary
                y: 150
                height: 41
                width: parent.width
                text: "简介"
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
        id: list
        width: parent.width
        anchors.top: top.bottom
        Rectangle {
            x: 70
            width: 60
            height: 30
            id: alis
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
            }
            Rectangle {
                width: 58
                height: 30
                x: 51
                y: 1
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
                Text {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    text: "歌手"
                }
            }
            Rectangle {
                width: 181
                height: 30
                x: 543
                y: 1
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
                Text {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    text: "时长"
                }
            }
        }
        Rectangle {
            clip: true
            width: parent.width
            height: 1000
            anchors.top: aliu.bottom
            ListModel {
                id: listdata
            }
            ListView {
                id: listview
                anchors.fill: parent
                //width: parent.width
                //anchors.top: aliu.bottom
                //height: 1000
                focus: true
                highlight: Rectangle {
                    color: "#ebeced"
                }
                Component {
                    id: atiem
                    Rectangle {
                        height: 28
                        width: 815
                        // color: Control.hoverEnabled ? ("#ebeced") : (mid % 2 ? "#fff" : "#f5f5f7")
                        color: number % 2 ? "#fff" : "#f5f5f7"
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
                            Text {
                                text: " ♡ "
                                anchors.fill: parent
                                anchors.leftMargin: 10
                                horizontalAlignment: Text.AlignLeft
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
    }
    function nextTick (res) {
        console.log(res)
        bigpic.source = res.playlist.coverImgUrl
        bigtitle.text = res.playlist.name
        creatorimg.source = res.playlist.creator.avatarUrl
        createDate.text = (new Date(res.playlist.createTime)).toLocaleString() + "创建"
        username.text = res.playlist.creator.nickname
        var str = ""
        var tags = res.playlist.tags
        str = tags.join(" / ")
        tag.text = "标签: " + str
        summary.text = "简介: " + res.playlist.description
        var list = res.playlist.tracks
        for (var i in list) {
            var a = list[i]
            listdata.append({
                                number: i * 1 + 1,
                                title: a.name,
                                singer: a.ar[0].name,
                                playlist: a.al.name,
                                time: ~~(a.dt / 1000 / 60) + ":" + ~~(a.dt / 1000) % 60,
                                mid: a.id
                            })
        }
    }
}
