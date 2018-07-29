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
    property real listnum: 0
    property string baseUrl: "http://music.163.com/song/media/outer/url?id="
    property string tailUrl: ".mp3"
    signal listBtnClickSignal
    signal nowIdSignal(var sid)
    function setListNum (num) {
        listnum = num
    }
    function getTimeStr (num) {
        num /= 1000
        num = ~~num
        var a = ~~(num / 60)
        if (a < 10) a = "0" + a
        var b = ~~(num % 60)
        if (b < 10) b = "0" + b
        return a + ":" + b
    }
    function freshList (lists) {
        console.log(lists)
        for (var i = 0; i < lists.length; i++){
            miusList.addItem(baseUrl + lists[i] + tailUrl)
        }
        console.log(miusList.items)
    }
    function addItem (id) {
        console.log(id)
        miusList.addItem(baseUrl + id + tailUrl)
    }
    function clear () {
        miusList.clear()
    }
    Playlist {
        id: miusList
        playbackMode: Playlist.Loop
    }
    MediaPlayer {
        id: miusPlayer
        source: ""
        onSourceChanged: function () {
            console.log("change")
        }

        onDurationChanged: function () {
            endReal = duration
        }

        onPositionChanged: function () {
            if (!miusSlider.isPressed) {
                miusSlider.value = position / duration
                nowReal = position
            }
            if (isStart && position == duration) {
                miusList.next()
                nowReal = 0
                nowIdSignal(miusList.currentItemSource)
                miusPlayer.stop()
                miusPlayer.source = miusList.currentItemSource
                miusPlayer.play()
            }
            // console.log(position,duration)
        }
        onError: function (e, estr) {
            console.log(e)
        }
    }
    function newPlay (sid) {
        sid = sid.toString()
        const url = baseUrl + sid + tailUrl
        console.log(url)
        // miusList.addItem(url)
        miusPlayer.source = url
        miusPlayer.play()
        isStart = true
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
                onClicked: function () {
                    miusList.previous()
                    nowIdSignal(miusList.currentItemSource)
                    miusPlayer.stop()
                    miusPlayer.source = miusList.currentItemSource
                    miusPlayer.play()
                }
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
                onClicked: function () {
                    miusList.next()
                    nowIdSignal(miusList.currentItemSource)
                    miusPlayer.stop()
                    miusPlayer.source = miusList.currentItemSource
                    miusPlayer.play()
                }
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
                    if (miusList.itemCount == 0) {
                        console.log("none of song")
                        return
                    }
                    isStart = true
                    miusPlayer.play()
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
                    miusPlayer.pause()
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
            font.family: "Arial, Helvetica, sans-serif"
        }
        Text {
            color: "#000"
            width: 41
            height: 14
            font.pixelSize: 14
            x: 700
            y: (48 - 14) / 2
            text: getTimeStr(endReal)
            font.family: "Arial, Helvetica, sans-serif"
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
                            miusPlayer.seek(miusSlider.value * miusPlayer.duration)
                        }
                        nowReal = miusSlider.value / (miusSlider.to - miusSlider.from) * endReal
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
            value: .5
            onValueChanged: function () {
                miusPlayer.volume = value
            }

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
                    onPositionChanged: function (p) {
                        if (pressed) {
                            volumeSlider.value += (mouseX - volumeSlider.ox) / miusSlider.width * (volumeSlider.to - volumeSlider.from)
                        }
                    }
                }
            }
        }
        Rectangle {
            x: parent.width - width - 14
            y: (parent.height - height) / 2
            width: 100
            height: 18
            color: "#e1e1e2"
            radius: 4
            Text {
                anchors.centerIn: parent
                text: "list: " + listnum
                font.family: "Arial, Helvetica, sans-serif"
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: function () {
                    listBtnClickSignal()
                }
            }
        }
    }
}
