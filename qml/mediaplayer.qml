import QtQuick 2.0
import QtMultimedia 5.9
import QtQuick.Controls 2.2
// import QtAV 1.6
Item {
    width: 1024
    height: 48
    property bool isStart: false
    property real nowReal: 0
    property real endReal: 258000
    function getTimeStr (num) {
        num /= 1000
        num = ~~num
        var a = ~~(num / 60)
        if (a < 10) a = "0" + a
        var b = ~~(num % 60)
        if (b < 10) b = "0" + b
        return a + ":" + b
    }
    /*
    VideoOutput2 {
        source: player
    }
    AVPlayer {
        id: player
        source: "http://m10.music.126.net/20180720180240/668b5bf09f997f70680dc165112ec015/ymusic/422b/6fbe/0594/7dc903a50dfefa3eac717c9a7fc52e4e.mp3"
    }
    */
    MediaPlayer {
        id: miusPlayer
        source: ""
        onSourceChanged: function () {
            miusSlider.value = 0
        }
        onPositionChanged: function () {
            if (!miusSlider.isPressed) {
                miusSlider.value = position / 1000
            }
        }
        onError: function (e, estr) {
            console.log(e)
        }
    }
    function newPlay (pak) {
        /*
        miusPlayer.source = pak.data[0].url
        miusPlayer.play()
        console.log(pak.data[0].url)
        */
        miusPlayer.source = pak.data[0].url
        console.log(miusPlayer.source)
        // miusPlayer.source = "http:///m10.music.126.net/20180720180240/668b5bf09f997f70680dc165112ec015/ymusic/422b/6fbe/0594/7dc903a50dfefa3eac717c9a7fc52e4e.mp3"
        miusPlayer.play()
        // player.play()
    }
    Rectangle {
        width: 1024
        height: 48
        color: "#f6f6f8"
        Image {
            width: 20
            height: 20
            x: 30
            y: (48 - 20) / 2
            source: "qrc:///img/note_btn_pre_white.png"
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }
        }
        Image {
            width: 20
            height: 20
            x: 172 - 20
            y: (48 - 20) / 2
            source: "qrc:///img/note_btn_next_white.png"
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }
        }
        Image {
            x: 83
            y: 7
            width: 34
            height: 34
            visible: !isStart
            id: start
            source: "qrc:///img/note_btn_play_white.png";
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: function () {
                    // signal
                    isStart = true
                }
            }
        }
        Image {
            x: 83
            y: 7
            width: 34
            height: 34
            id: pause
            visible: isStart
            source: "qrc:///img/pause.png"
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: function () {
                    // signal
                    isStart = false
                }
            }
        }
        Text {
            color: "#000"
            width: 41
            height: 14
            font.pixelSize: 14
            x: 200
            y: (48 - 14) / 2
            text: getTimeStr(nowReal)
        }
        Text {
            color: "#000"
            width: 41
            height: 14
            font.pixelSize: 14
            x: 700
            y: (48 - 14) / 2
            text: getTimeStr(endReal)
        }
        Slider {
            id: miusSlider
            property bool isPressed: false
            property real ox: 0
            width: 441
            height: 48
            x: 248
            y: 0
            background: Rectangle {
                width: 441
                height: 4
                y: 22
                color: "#e6e6e8"
                radius: height / 2
                Rectangle {
                    color: "#e83c3c"
                    width: miusSlider.value / (miusSlider.to - miusSlider.from) * parent.width
                    height: parent.height
                    radius: height / 2
                }
            }
            handle: Rectangle {
                width: 14
                height: 14
                radius: width / 2
                color: "#fff"
                border.width: 1
                border.color: "#c6c6c6"
                x: miusSlider.value / (miusSlider.to - miusSlider.from) * parent.width - width / 2
                y: 17
                Rectangle {
                    width: 3
                    height: 3
                    radius: width / 2
                    color: "#e83c3c"
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onPressed: function () {
                        miusSlider.isPressed = true
                        miusSlider.ox = mouseX
                    }
                    onReleased: function () {
                        miusSlider.isPressed  = false
                        // call media
                    }

                    onPositionChanged: function () {
                        if (pressed) {
                            miusSlider.value += (mouseX - miusSlider.ox) / miusSlider.width * (miusSlider.to - miusSlider.from)
                            nowReal = miusSlider.value / (miusSlider.to - miusSlider.from) * endReal
                        }
                    }

                }
            }
        }
        Slider {
            id: volumeSlider
            property bool isPressed: false
            property real ox: 0
            width: 100
            height: 48
            x: 770
            y: 0
            background: Rectangle {
                width: 100
                height: 4
                y: 22
                color: "#e6e6e8"
                radius: height / 2
                Rectangle {
                    color: "#e83c3c"
                    width: volumeSlider.value / (volumeSlider.to - volumeSlider.from) * parent.width
                    height: parent.height
                    radius: height / 2
                }
            }
            handle: Rectangle {
                id: vhand
                width: 10
                height: 10
                radius: width / 2
                color: "#fff"
                border.width: 1
                border.color: "#c6c6c6"
                x: volumeSlider.value / (volumeSlider.to - volumeSlider.from) * parent.width - width / 2
                y: (48 - height) / 2
                Rectangle {
                    width: 3
                    height: 3
                    radius: width / 2
                    color: "#e83c3c"
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onPressed: function () {
                        volumeSlider.isPressed = true
                        volumeSlider.ox = mouseX
                    }
                    onReleased: function () {
                        volumeSlider.isPressed  = false
                        // call media
                    }
                    onEntered: vhand.width = vhand.height = 14
                    onExited: vhand.width = vhand.height = 10
                    onPositionChanged: function () {
                        if (pressed) {
                            volumeSlider.value += (mouseX - volumeSlider.ox) / miusSlider.width * (volumeSlider.to - volumeSlider.from)
                            // change volume
                        }
                    }
                }
            }
        }
    }
}
