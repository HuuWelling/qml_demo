import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Particles 2.2

Window {
    id: root
    width: 1920/2
    height: 897/2
    visible: true
    title: qsTr("ELDEN RING")

    Image {
        id: bg
        source: "qrc:/bg.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    ParticleSystem {
        id: sys
        width: parent.width/3*0.75
        height: parent.height/3*1.5
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height/10

        ImageParticle {
            id: smoke
            anchors.fill: parent
            groups: ["A"]
            source: "qrc:///particleresources/glowdot.png"
            colorVariation: 0
            color: "#00111111"
        }
        ImageParticle {
            id: flame
            anchors.fill: parent
            groups: ["B"]
            source: "qrc:///particleresources/glowdot.png"
            colorVariation: 0.1
            color: "#00ff400f"
        }

        Emitter {
            id: fire
            group: "B"

            emitRate: 1000
            lifeSpan: 2000

            acceleration: PointDirection { y: -3; xVariation: 3 }
            velocity: PointDirection {xVariation: 3}

            size: 24
            sizeVariation: 8
            endSize: 4

            //! [0]
            anchors.fill: parent
            shape: MaskShape {
                source: "qrc:/ring.png"
            }
            //! [0]
        }

        TrailEmitter {
            id: fireSmoke
            group: "A"
            follow: "B"
            width: sys.width
            height: sys.height - 68

            emitRatePerParticle: 1
            lifeSpan: 200

            velocity: PointDirection {y:-1; yVariation: -1; xVariation: 3}
            acceleration: PointDirection {xVariation: 3}

            size: 36
            sizeVariation: 8
            endSize: 16
        }

        SequentialAnimation {
            running: true
            loops: Animation.Infinite
            NumberAnimation { target: sys; property: "y"; from: root.height/10; to: root.height/10+10; duration: 1000 }
            NumberAnimation { target: sys; property: "y"; from: root.height/10+10; to: root.height/10; duration: 1000 }
        }
    }

}
