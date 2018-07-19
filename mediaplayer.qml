import QtQuick 2.0
import QtMultimedia 5.9
import QtQuick.Controls 2.2
Item {
    width: 1022
    height: 46
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
        // miusPlayer.source = pak.data[0].url
        miusPlayer.source = "file:///D:/CloudMusic/洛天依,乐正绫 - 灼之花.mp3"
        miusPlayer.play()
    }
    Rectangle {
        width: 1022
        height: 46
        color: "#f6f6f8"
        Slider {
            id: miusSlider
            property bool isPressed: false
            property real ox: 0
            width: 441
            height: 46
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
                        }
                        console.log(miusSlider.value)
                    }

                }
            }
        }
    }
}
