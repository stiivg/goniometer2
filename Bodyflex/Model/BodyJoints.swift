//
//  BodyJoints.swift
//  bodyflex
//
//  Created by Steven Gallagher on 12/24/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

struct NameType {
    var common: String
    let medical: String
}

struct MotionStruct {
    let name: NameType
    let stationaryLabel: NameType
    let axisLabel: NameType
    let movingLabel: NameType
    let normalAMA: String
    let normalAAOS: String
    let position: String
    let description: String
    let rotation: String
    let insideOutside: String
    let defaultDotPoints: [CGPoint]
    let labelOffsets: [String]
}

struct Joint {
    var name: NameType
    let motions: [MotionStruct]
}

let shoulderJoint = Joint.init(name: .init(common: "Shoulder", medical: ""),
                               motions: [
                                MotionStruct.init(name: .init(common: "Arm Raise", medical: "Flexion"),
                                    stationaryLabel: .init(common: "Back", medical: "Mid-axillary Line"),
                                    axisLabel: .init(common: "Shoulder", medical: "Head of Humerus"),
                                    movingLabel: .init(common: "Elbow", medical: "Midline of Humerus"),
                                    normalAMA: "150",
                                    normalAAOS: "167,4.7",
                                    position: "",
                                    description: "Raise arm forward over head",
                                    rotation: "CCW",
                                    insideOutside: "Inside",
                                    defaultDotPoints: [CGPoint(x: 1184, y: 925), CGPoint(x: 697, y: 918), CGPoint(x: 251, y: 764)],
                                    labelOffsets: ["Down", "Down", "Up"]),
                                MotionStruct.init(name: .init(common: "Arm Reverse Raise", medical: "Extension"),
                                    stationaryLabel: .init(common: "Back", medical: "Mid-axillary Line"),
                                    axisLabel: .init(common: "Shoulder", medical: "Acromium Process (center of humeral head)"),
                                    movingLabel: .init(common: "Elbow", medical: "Lateral Epicondyle"),
                                    normalAMA: "50",
                                    normalAAOS: "62,9.5",
                                    position: "",
                                    description: "Raise arm backward",
                                    rotation: "CW",
                                    insideOutside: "Inside",
                                    defaultDotPoints:  [CGPoint(x: 96, y: 1115), CGPoint(x: 731, y: 1095), CGPoint(x: 361, y: 773)],
                                    labelOffsets: ["Down", "Down", "Up"]),
                                MotionStruct.init(name: .init(common: "Arm Raise to Side", medical: "Abduction"),
                                    stationaryLabel: .init(common: "Side", medical: "Parallel to Sternum"),
                                    axisLabel: .init(common: "Shoulder", medical: "Humeral Head"),
                                    movingLabel: .init(common: "Elbow", medical: "Midline of Humerus"),
                                    normalAMA: "180",
                                    normalAAOS: "184,7.0",
                                    position: "",
                                    description: "Raise arm away from body above head",
                                    rotation: "CW",
                                    insideOutside: "Inside",
                                    defaultDotPoints: [CGPoint(x: 1157, y: 955), CGPoint(x: 616, y: 913), CGPoint(x: 108, y: 1119)],
                                    labelOffsets: ["Down", "Up", "Up"]),
                                MotionStruct.init(name: .init(common: "Bent Arm Lower", medical: "Medial Rotation"),
                                    stationaryLabel: .init(common: "Vertical", medical: ""),
                                    axisLabel: .init(common: "Elbow", medical: "Olecranon Process"),
                                    movingLabel: .init(common: "Wrist", medical: "Ulnar Styloid"),
                                    normalAMA: "90",
                                    normalAAOS: "69,4.6",
                                    position: "",
                                    description: "Arm raised to side, bend elbow 90 degrees and rotate at shoulder to lower hand",
                                    rotation: "CW",
                                    insideOutside: "Inside",
                                    defaultDotPoints:  [CGPoint(x: 242, y: 426), CGPoint(x: 243, y: 1228), CGPoint(x: 786, y: 782)],
                                    labelOffsets: ["Up", "Down", "Up"]),
                                MotionStruct.init(name: .init(common: "Bent Arm Raise", medical: "Lateral Rotation"),
                                    stationaryLabel: .init(common: "Vertical", medical: ""),
                                    axisLabel: .init(common: "Elbow", medical: "Olecranon Process"),
                                    movingLabel: .init(common: "Wrist", medical: "Ulnar Styloid"),
                                    normalAMA: "90",
                                    normalAAOS: "104,8.5",
                                    position: "",
                                    description: "Arm raised to side, bend elbow 90 degrees and rotate at shoulder to raise hand",
                                    rotation: "CCW",
                                    insideOutside: "Inside",
                                    defaultDotPoints: [CGPoint(x: 1033, y: 363), CGPoint(x: 1030, y: 844), CGPoint(x: 448, y: 906)],
                                    labelOffsets: ["Up", "Up", "Up"]) ])

let elbowJoint = Joint.init(name: .init(common: "Elbow", medical: ""),
                           motions: [
                            MotionStruct.init(name: .init(common: "Arm Curl", medical: "Flexion"),
                                stationaryLabel: .init(common: "Shoulder", medical: "Acromion Process"),
                                axisLabel: .init(common: "Elbow", medical: "Lateral Epicondyle"),
                                movingLabel: .init(common: "Wrist", medical: "Radial Styloid"),
                                normalAMA: "140",
                                normalAAOS: "141,4.9",
                                position: "",
                                description: "Bend arm bringing wrist to shoulder",
                                rotation: "CCW",
                                insideOutside: "Outside",
                                defaultDotPoints: [CGPoint(x: 509, y: 1039), CGPoint(x: 1077, y: 1123), CGPoint(x: 713, y: 824)],
                                labelOffsets: ["Down", "Down", "Up"]),
                            MotionStruct.init(name: .init(common: "Straighten Arm", medical: "Extension"),
                                stationaryLabel: .init(common: "Shoulder", medical: "Acromion Process"),
                                axisLabel: .init(common: "Elbow", medical: "Lateral Epicondyle"),
                                movingLabel: .init(common: "Wrist", medical: "Radial Styloid"),
                                normalAMA: "0",
                                normalAAOS: "0.3,2.0",
                                position: "",
                                description: "Straighten arm from curl",
                                rotation: "CW",
                                insideOutside: "Outside",
                                defaultDotPoints: [CGPoint(x: 326, y: 1015), CGPoint(x: 821, y: 1024), CGPoint(x: 1208, y: 1054)],
                                labelOffsets: ["Down", "Down", "Down"])
    ])

let forearm = Joint.init(name: .init(common: "Forearm", medical: ""),
                            motions: [
                                MotionStruct.init(name: .init(common: "Palm Up", medical: "Supination"),
                                                       stationaryLabel: .init(common: "Parallel to Upper Arm", medical: "Parallel to Humerus"),
                                                       axisLabel: .init(common: "Inside Wrist", medical: "Medial to Ulnar Styloid"),
                                                       movingLabel: .init(common: "Outside Wrist", medical: "Ventral Aspect of Distal Radius"),
                                                       normalAMA: "80",
                                                       normalAAOS: "81,4.0",
                                                       position: "",
                                                       description: "Turn lower arm so palm faces up",
                                                       rotation: "CCW",
                                                       insideOutside: "Inside",
                                                       defaultDotPoints: [CGPoint(x: 961, y: 353), CGPoint(x: 959, y: 1139), CGPoint(x: 363, y: 1077)],
                                                       labelOffsets: ["Up", "Down", "Up"]),
                                MotionStruct.init(name: .init(common: "Palm Down", medical: "Pronation"),
                                                       stationaryLabel: .init(common: "Parallel to Upper Arm", medical: "Parallel to Humerus"),
                                                       axisLabel: .init(common: "Outside Wrist", medical: "Lateral to Ulnar Styloid"),
                                                       movingLabel: .init(common: "Inside Wrist", medical: "Dorsal Aspect of Distal Radius"),
                                                       normalAMA: "80",
                                                       normalAAOS: "75,5.3",
                                                       position: "",
                                                       description: "Turn lower arm so palm faces down",
                                                       rotation: "CW",
                                                       insideOutside: "Inside",
                                                       defaultDotPoints: [CGPoint(x: 467, y: 385), CGPoint(x: 347, y: 1180), CGPoint(x: 921, y: 1086)],
                                                       labelOffsets: ["Up", "Down", "Up"]),])

let wristJoint = Joint.init(name: .init(common: "Wrist", medical: ""),
                         motions: [
                            MotionStruct.init(name: .init(common: "Hand Lowered", medical: "Flexion"),
                                                   stationaryLabel: .init(common: "Parallel to Lower Arm", medical: "Ulna"),
                                                   axisLabel: .init(common: "Wrist", medical: "Triquetum"),
                                                   movingLabel: .init(common: "Hand", medical: "5th Metacarpal"),
                                                   normalAMA: "60",
                                                   normalAAOS: "75,6.6",
                                                   position: "",
                                                   description: "Lower hand at wrist with fingers relaxed",
                                                   rotation: "CW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 363, y: 816), CGPoint(x: 891, y: 678), CGPoint(x: 1066, y: 993)],
                                                   labelOffsets: ["Down", "Up", "Down"]),
                            MotionStruct.init(name: .init(common: "Hand Raised", medical: "Extension"),
                                                   stationaryLabel: .init(common: "Parallel to Lower Arm", medical: "Ulna"),
                                                   axisLabel: .init(common: "Wrist", medical: "Triquetum"),
                                                   movingLabel: .init(common: "Hand", medical: "5th Metacarpal"),
                                                   normalAMA: "60",
                                                   normalAAOS: "74,6.6",
                                                   position: "",
                                                   description: "Raise hand at wrist with fingers relaxed",
                                                   rotation: "CCW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 401, y: 955), CGPoint(x: 901, y: 932), CGPoint(x: 1038, y: 661)],
                                                   labelOffsets: ["Down", "Down", "Up"]),
                            MotionStruct.init(name: .init(common: "Hand Out", medical: "Radial Deviation"),
                                                   stationaryLabel: .init(common: "Elbow", medical: "Lateral Epicondyle"),
                                                   axisLabel: .init(common: "Wrist", medical: "Capitate"),
                                                   movingLabel: .init(common: "Middle Finger", medical: "Middle Metacarpal"),
                                                   normalAMA: "20",
                                                   normalAAOS: "21,4.0",
                                                   position: "",
                                                   description: "Rotate hand sidewyas at wrist away from body",
                                                   rotation: "CW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 524, y: 394), CGPoint(x: 761, y: 980), CGPoint(x: 735, y: 1280)],
                                                   labelOffsets: ["Left", "Right", "Down"]),
                            MotionStruct.init(name: .init(common: "Hand In", medical: "Ulnar Deviation"),
                                                   stationaryLabel: .init(common: "Elbow", medical: "Lateral Epicondyle"),
                                                   axisLabel: .init(common: "Wrist", medical: "Capitate"),
                                                   movingLabel: .init(common: "Middle Finger", medical: "Middle Metacarpal"),
                                                   normalAMA: "30",
                                                   normalAAOS: "35,3.8",
                                                   position: "",
                                                   description: "Rotate hand sidways at wrist towards body",
                                                   rotation: "CCW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 547, y: 459), CGPoint(x: 618, y: 1055), CGPoint(x: 789, y: 1381)],
                                                   labelOffsets: ["Left", "Left", "Down"]),])

let knuckleJoint = Joint.init(name: .init(common: "Knuckle", medical: "Metacarpophalangeal"),
                              motions: [
                                MotionStruct.init(name: .init(common: "Lower Fingers", medical: "Flexion"),
                                                       stationaryLabel: .init(common: "Back of Hand", medical: "Aligned with Metacarpal"),
                                                       axisLabel: .init(common: "Knuckle", medical: "Dorsal Metacarpophalangeal Joint"),
                                                       movingLabel: .init(common: "Finger", medical: "Aligned with Proximal Phalange"),
                                                       normalAMA: "90",
                                                       normalAAOS: "86",
                                                       position: "",
                                                       description: "Lower finger at first knuckle",
                                                       rotation: "CCW",
                                                       insideOutside: "Outside",
                                                       defaultDotPoints: [CGPoint(x: 857, y: 786), CGPoint(x: 591, y: 523), CGPoint(x: 232, y: 739)],
                                                       labelOffsets: ["Up", "Up", "Up"]),
                                MotionStruct.init(name: .init(common: "Raise Fingers", medical: "Extension"),
                                                       stationaryLabel: .init(common: "Back of Hand", medical: "Aligned with Metacarpal"),
                                                       axisLabel: .init(common: "Knuckle", medical: "Dorsal Metacarpophalangeal Joint"),
                                                       movingLabel: .init(common: "Finger", medical: "Aligned with Proximal Phalange"),
                                                       normalAMA: "20",
                                                       normalAAOS: "22",
                                                       position: "",
                                                       description: "Raise finger at first knuckle",
                                                       rotation: "CW",
                                                       insideOutside: "Outside",
                                                       defaultDotPoints: [CGPoint(x: 831, y: 757), CGPoint(x: 539, y: 613), CGPoint(x: 255, y: 444)],
                                                       labelOffsets: ["Down", "Up", "Up"]),
                                MotionStruct.init(name: .init(common: "Finger Towards Thumb", medical: "Abduction"),
                                                       stationaryLabel: .init(common: "Back of Hand", medical: "Aligned with Metacarpal"),
                                                       axisLabel: .init(common: "Knuckle", medical: "Dorsal Metacarpophalangeal Joint"),
                                                       movingLabel: .init(common: "Finger", medical: "Aligned with Proximal Phalange"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
                                                       position: "",
                                                       description: "Move finger sideways towards thumb",
                                                       rotation: "CCW",
                                                       insideOutside: "Outside",
                                                       defaultDotPoints: [CGPoint(x: 960, y: 793), CGPoint(x: 563, y: 816), CGPoint(x: 364, y: 874)],
                                                       labelOffsets: ["Down", "Up", "Down"]),
                                MotionStruct.init(name: .init(common: "Finger Away From Thumb", medical: "Adduction"),
                                                       stationaryLabel: .init(common: "Back of Hand", medical: "Aligned with Metacarpal"),
                                                       axisLabel: .init(common: "Knuckle", medical: "Dorsal Metacarpophalangeal Joint"),
                                                       movingLabel: .init(common: "Finger", medical: "Aligned with Proximal Phalange"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
                                                       position: "",
                                                       description: "Move finger sideways away from thumb",
                                                       rotation: "CW",
                                                       insideOutside: "Outside",
                                                       defaultDotPoints: [CGPoint(x: 896, y: 923), CGPoint(x: 597, y: 834), CGPoint(x: 420, y: 732)],
                                                       labelOffsets: ["Down", "Up", "Down"]),])

let fingerJoint = Joint.init(name: .init(common: "Finger", medical: "Interphalangeal"),
                             motions: [
                                MotionStruct.init(name: .init(common: "Bend", medical: "Flexion"),
                                                       stationaryLabel: .init(common: "Base of Finger", medical: "Aligned with Proximal Phalange"),
                                                       axisLabel: .init(common: "Finger Joint", medical: "Dorsal Proximal Interphalangeal Joint"),
                                                       movingLabel: .init(common: "Upper Finger Joint", medical: "Aligned with Middle Phalange"),
                                                       normalAMA: "100", //Various for each finger
                                    normalAAOS: "102", //Various for each finger
                                    position: "",
                                    description: "",
                                    rotation: "CCW",
                                    insideOutside: "Outside",
                                    defaultDotPoints: [CGPoint(x: 705, y: 454), CGPoint(x: 231, y: 904), CGPoint(x: 687, y: 1142)],
                                    labelOffsets: ["Up", "Up", "Down"]),
                                MotionStruct.init(name: .init(common: "Straighten", medical: "Extension"),
                                                       stationaryLabel: .init(common: "Base of Finger", medical: "Aligned with Proximal Phalange"),
                                                       axisLabel: .init(common: "Finger Joint", medical: "Dorsal Proximal Interphalangeal Joint"),
                                                       movingLabel: .init(common: "Upper Finger Joint", medical: "Aligned with Middle Phalange"),
                                                       normalAMA: "0", //Various for each finger
                                    normalAAOS: "7", //Various for each finger
                                    position: "",
                                    description: "",
                                    rotation: "CW",
                                    insideOutside: "Outside",
                                    defaultDotPoints: [CGPoint(x: 913, y: 672), CGPoint(x: 561, y: 681), CGPoint(x: 252, y: 672)],
                                    labelOffsets: ["Up", "Down", "Up"]),])

let thumb = Joint.init(name: .init(common: "Thumb", medical: "Thumb Carpometacarpal"),
                             motions: [
                                MotionStruct.init(name: .init(common: "In", medical: "Flexion"),
                                                       stationaryLabel: .init(common: "Aligned with Arm", medical: "Aligned with Radius"),
                                                       axisLabel: .init(common: "Wrist", medical: "Carpometacarpal Joint"),
                                                       movingLabel: .init(common: "Base of Thumb", medical: "Thumb Metacarpal"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
                                                       position: "",
                                                       description: "",
                                                       rotation: "CW",
                                                       insideOutside: "Outside",
                                                       defaultDotPoints: [CGPoint(x: 611, y: 92), CGPoint(x: 669, y: 635), CGPoint(x: 580, y: 1189)],
                                                       
                                                       labelOffsets: ["Left", "Left", "Left"]),
                                MotionStruct.init(name: .init(common: "Out", medical: "Extension"),
                                                       stationaryLabel: .init(common: "Aligned with Arm", medical: "Aligned with Radius"),
                                                       axisLabel: .init(common: "Wrist", medical: "Carpometacarpal Joint"),
                                                       movingLabel: .init(common: "Base of Thumb", medical: "Thumb Metacarpal"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
                                                       position: "",
                                                       description: "",
                                                       rotation: "CW",
                                                       insideOutside: "Outside",
                                                       defaultDotPoints: [CGPoint(x: 736, y: 65), CGPoint(x: 756, y: 538), CGPoint(x: 316, y: 912)],
                                                       labelOffsets: ["Left", "Left", "Down"]),
                                MotionStruct.init(name: .init(common: "Down", medical: "Abduction"),
                                                       stationaryLabel: .init(common: "Finger", medical: "Finger Metacarpal"),
                                                       axisLabel: .init(common: "Wrist", medical: "Radial Styloid"),
                                                       movingLabel: .init(common: "Base of Thumb", medical: "Thumb Metacarpal"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
                                                       position: "",
                                                       description: "",
                                                       rotation: "CCW",
                                                       insideOutside: "Inside",
                                                       defaultDotPoints: [CGPoint(x: 298, y: 917), CGPoint(x: 904, y: 823), CGPoint(x: 638, y: 1238)],
                                                       labelOffsets: ["Down", "Up", "Right"]),
                                MotionStruct.init(name: .init(common: "Up", medical: "Adduction"),
                                                       stationaryLabel: .init(common: "Finger", medical: "Finger Metacarpal"),
                                                       axisLabel: .init(common: "Wrist", medical: "Radial Styloid"),
                                                       movingLabel: .init(common: "Base of Thumb", medical: "Thumb Metacarpal"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
                                                       position: "",
                                                       description: "",
                                                       rotation: "CCW",
                                                       insideOutside: "Inside",
                                                       defaultDotPoints: [CGPoint(x: 559, y: 783), CGPoint(x: 1029, y: 776), CGPoint(x: 685, y: 889)],
                                                       labelOffsets: ["Up", "Up", "Down"]),])

let hipJoint = Joint.init(name: .init(common: "Hip", medical: ""),
                           motions: [
                            MotionStruct.init(name: .init(common: "Thigh Forward", medical: "Flexion"),
                                                   stationaryLabel: .init(common: "Body Line", medical: "Midline of Pelvis"),
                                                   axisLabel: .init(common: "Hip Bone", medical: "Greater Trochanter"),
                                                   movingLabel: .init(common: "Knee", medical: "Lateral Epicondyle"),
                                                   normalAMA: "100",
                                                   normalAAOS: "121,6.4",
                                                   position: "",
                                                   description: "",
                                                   rotation: "CCW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 84, y: 1306), CGPoint(x: 548, y: 1320), CGPoint(x: 685, y: 790)],
                                                   labelOffsets: ["Up", "Down", "Left"]),
                            MotionStruct.init(name: .init(common: "Thigh Back", medical: "Extension"),
                                                   stationaryLabel: .init(common: "Body Line", medical: "Midline of Pelvis"),
                                                   axisLabel: .init(common: "Hip Bone", medical: "Greater Trochanter"),
                                                   movingLabel: .init(common: "Knee", medical: "Lateral Epicondyle"),
                                                   normalAMA: "30",
                                                   normalAAOS: "12,5.4",
                                                   position: "",
                                                   description: "",
                                                   rotation: "CW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                   labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Thigh Out", medical: "Abduction"),
                                                   stationaryLabel: .init(common: "Opposite Hip Bone", medical: "Aligned with Opposite ASIS"),
                                                   axisLabel: .init(common: "Hip Bone", medical: "Anterior Superior Iliac Spine (ASIS)"),
                                                   movingLabel: .init(common: "Knee", medical: "Center of Patella"),
                                                   normalAMA: "40",
                                                   normalAAOS: "41,6.0",
                                                   position: "",
                                                   description: "",
                                                   rotation: "CW",
                                                   insideOutside: "Inside-90",
                                                   defaultDotPoints: [CGPoint(x: 977, y: 1398), CGPoint(x: 1030, y: 864), CGPoint(x: 204, y: 214)],
                                                   labelOffsets: ["Down", "Up", "Right"]),
                            MotionStruct.init(name: .init(common: "Thigh In", medical: "Adduction"),
                                                   stationaryLabel: .init(common: "Opposite Hip Bone", medical: "Aligned with Opposite ASIS"),
                                                   axisLabel: .init(common: "Hip Bone", medical: "Anterior Superior Iliac Spine (ASIS)"),
                                                   movingLabel: .init(common: "Knee", medical: "Center of Patella"),
                                                   normalAMA: "20",
                                                   normalAAOS: "27,3.6",
                                                   position: "",
                                                   description: "",
                                                   rotation: "CW",
                                                   insideOutside: "Inside-90",
                                                   defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                   labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Leg Out", medical: "Medial (Internal) Rotation"),
                                                   stationaryLabel: .init(common: "Aligned Vertically", medical: ""),
                                                   axisLabel: .init(common: "Knee", medical: "Center of Patella"),
                                                   movingLabel: .init(common: "Ankle", medical: "Crest of Tibia"),
                                                   normalAMA: "40",
                                                   normalAAOS: "44,4.3",
                                                   position: "",
                                                   description: "",
                                                   rotation: "CW",
                                                   insideOutside: "Inside",
                                                   defaultDotPoints: [CGPoint(x: 813, y: 1361), CGPoint(x: 824, y: 494), CGPoint(x: 460, y: 1069)],
                                                   labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Leg In", medical: "Lateral (External) Rotation"),
                                                   stationaryLabel: .init(common: "Aligned Vertically", medical: ""),
                                                   axisLabel: .init(common: "Knee", medical: "Center of Patella"),
                                                   movingLabel: .init(common: "Ankle", medical: "Crest of Tibia"),
                                                   normalAMA: "50",
                                                   normalAAOS: "44,4.8",
                                                   position: "",
                                                   description: "",
                                                   rotation: "CCW",
                                                   insideOutside: "Inside",
                                                   defaultDotPoints: [CGPoint(x: 430, y: 1260), CGPoint(x: 406, y: 412), CGPoint(x: 921, y: 1150)],
                                                   labelOffsets: ["Up", "Up", "Up"]),])

let kneeJoint = Joint.init(name: .init(common: "Knee", medical: ""),
                           motions: [
                            MotionStruct.init(name: .init(common: "Bend", medical: "Flexion"),
                                                   stationaryLabel: .init(common: "Hip Bone", medical: "Greater Trochanter"),
                                                   axisLabel: .init(common: "Knee", medical: "Lateral Epicondyle"),
                                                   movingLabel: .init(common: "Ankle", medical: "Lateral Malleolus"),
                                                   normalAMA: "150",
                                                   normalAAOS: "141,5.3",
                                                   position: "",
                                                   description: "",
                                                   rotation: "CW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 581, y: 1174), CGPoint(x: 165, y: 524), CGPoint(x: 879, y: 777)],
                                                   labelOffsets: ["Right", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Straighten", medical: "Extension"),
                                                   stationaryLabel: .init(common: "Hip Bone", medical: "Greater Trochanter"),
                                                   axisLabel: .init(common: "Knee", medical: "Lateral Epicondyle"),
                                                   movingLabel: .init(common: "Ankle", medical: "Lateral Malleolus"),
                                                   normalAMA: "0", //Guessed
                                                   normalAAOS: "0,10", //Guessed
                                                   position: "",
                                                   description: "",
                                                   rotation: "CCW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 113, y: 831), CGPoint(x: 525, y: 849), CGPoint(x: 1088, y: 850)],
                                                   labelOffsets: ["Up", "Down", "Up"]),])

let ankleJoint = Joint.init(name: .init(common: "Ankle", medical: "Talocrural Joint"),
                           motions: [
                            MotionStruct.init(name: .init(common: "Raise Foot", medical: "Dorsiflexion"),
                                                   stationaryLabel: .init(common: "Knee", medical: "Fibular Head"),
                                                   axisLabel: .init(common: "Ankle", medical: "Lateral Malleolus"),
                                                   movingLabel: .init(common: "Aligned to Foot", medical: "Parallel to Fifth Metatarsal"),
                                                   normalAMA: "20",
                                                   normalAAOS: "13,4.4",
                                                   position: "",
                                                   description: "Bend ankle so toes point up",
                                                   rotation: "CCW",
                                                   insideOutside: "Outside-90",
                                                   defaultDotPoints: [CGPoint(x: 745, y: 346), CGPoint(x: 770, y: 1136), CGPoint(x: 1020, y: 1000)],
                                                   labelOffsets: ["Right", "Left", "Right"]),
                            MotionStruct.init(name: .init(common: "Lower Foot", medical: "Plantarflexion"),
                                                   stationaryLabel: .init(common: "Knee", medical: "Fibular Head"),
                                                   axisLabel: .init(common: "Ankle", medical: "Lateral Malleolus"),
                                                   movingLabel: .init(common: "Aligned to Foot", medical: "Parallel to Fifth Metatarsal"),
                                                   normalAMA: "50",
                                                   normalAAOS: "56,6.1",
                                                   position: "",
                                                   description: "Bend ankle so toes point down",
                                                   rotation: "CW",
                                                   insideOutside: "Inside-90",
                                                   defaultDotPoints: [CGPoint(x: 745, y: 346), CGPoint(x: 770, y: 1136), CGPoint(x: 981, y: 1405)],
                                                   labelOffsets: ["Right", "Right", "Down"]),])

let heelJoint = Joint.init(name: .init(common: "Heel", medical: "Calcaneal (subtalar - hindfoot)"),
                           motions: [
                            MotionStruct.init(name: .init(common: "Roll Out", medical: "Inversion"),
                                              stationaryLabel: .init(common: "Midline of Leg", medical: ""),
                                              axisLabel: .init(common: "", medical: ""),
                                              movingLabel: .init(common: "Midline of Heel", medical: "Midline of Calcaneus"),
                                              normalAMA: "",
                                              normalAAOS: "37,4.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside",
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Roll In", medical: "Eversion"),
                                              stationaryLabel: .init(common: "Midline of Leg", medical: ""),
                                              axisLabel: .init(common: "", medical: ""),
                                              movingLabel: .init(common: "Midline of Heel", medical: "Midline of Calcaneus"),
                                              normalAMA: "",
                                              normalAAOS: "21,5.0",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside",
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),])

let footJoint = Joint.init(name: .init(common: "Foot", medical: "Midtarsal (transverse tarsal) "),
                           motions: [
                            MotionStruct.init(name: .init(common: "Rotate Out", medical: "Inversion"),
                                              stationaryLabel: .init(common: "Midline of Leg", medical: ""),
                                              axisLabel: .init(common: "", medical: ""),
                                              movingLabel: .init(common: "Aligned with Sole", medical: "Aligned with Plantar Aspect of Metatarsal Heads"),
                                              normalAMA: "",
                                              normalAAOS: "",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside-90",
                                              defaultDotPoints: [CGPoint(x: 955, y: 316), CGPoint(x: 890, y: 1512), CGPoint(x: 209, y: 1298)],
                                              labelOffsets: ["Right", "Down", "Down"]),
                            MotionStruct.init(name: .init(common: "Rotate In", medical: "Eversion"),
                                              stationaryLabel: .init(common: "Midline of Leg", medical: ""),
                                              axisLabel: .init(common: "", medical: ""),
                                              movingLabel: .init(common: "Aligned with Sole", medical: "Aligned with Plantar Aspect of Metatarsal Heads"),
                                              normalAMA: "",
                                              normalAAOS: "",
                                              position: "",
                                              description: "",
                                              rotation: "CCW",
                                              insideOutside: "Outside-90",
                                              defaultDotPoints: [CGPoint(x: 328, y: 211), CGPoint(x: 381, y: 1529), CGPoint(x: 1051, y: 1213)],
                                              labelOffsets: ["Left", "Down", "Down"]),])

let toeJoint = Joint.init(name: .init(common: "Toe", medical: "Metatarsophalangeal"),
                           motions: [
                            MotionStruct.init(name: .init(common: "Raise", medical: "Dorsiflexion"),
                                              stationaryLabel: .init(common: "Ankle", medical: "Aligned to Metatarsal"),
                                              axisLabel: .init(common: "Base of Toe", medical: "Medial to Center of Metararsal Head"),
                                              movingLabel: .init(common: "Aligned with Toe", medical: "Aligned with Proximal Phalange"),
                                              normalAMA: "50",
                                              normalAAOS: "",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside",
                                              defaultDotPoints: [CGPoint(x: 746, y: 1184), CGPoint(x: 339, y: 755), CGPoint(x: 370, y: 481)],
                                              labelOffsets: ["Up", "Right", "Up"]),
                            MotionStruct.init(name: .init(common: "Lower", medical: "Plantarflexion"),
                                              stationaryLabel: .init(common: "Ankle", medical: "Aligned to Metatarsal"),
                                              axisLabel: .init(common: "Base of Toe", medical: "Medial to Center of Metararsal Head"),
                                              movingLabel: .init(common: "Aligned with Toe", medical: "Aligned with Proximal Phalange"),
                                              normalAMA: "30",
                                              normalAAOS: "",
                                              position: "",
                                              description: "",
                                              rotation: "CCW",
                                              insideOutside: "Outside",
                                              defaultDotPoints: [CGPoint(x: 676, y: 1198), CGPoint(x: 414, y: 710), CGPoint(x: 158, y: 404)],
                                              labelOffsets: ["Up", "Right", "Up"]),
                            MotionStruct.init(name: .init(common: "Out", medical: "Abduction"),
                                              stationaryLabel: .init(common: "Aligned with Foot", medical: "Aligned to Metatarsal"),
                                              axisLabel: .init(common: "Base of Toe", medical: "Center of Metararsal Head"),
                                              movingLabel: .init(common: "Aligned with Toe", medical: "Aligned with Proximal Phalange"),
                                              normalAMA: "",
                                              normalAAOS: "",
                                              position: "",
                                              description: "",
                                              rotation: "CCW",
                                              insideOutside: "Outside",
                                              defaultDotPoints: [CGPoint(x: 720, y: 1447), CGPoint(x: 594, y: 797), CGPoint(x: 556, y: 440)],
                                              labelOffsets: ["Left", "Left", "Up"]),
                            MotionStruct.init(name: .init(common: "In", medical: "Adduction"),
                                              stationaryLabel: .init(common: "Aligned with Foot", medical: "Aligned to Metatarsal"),
                                              axisLabel: .init(common: "Base of Toe", medical: "Center of Metararsal Head"),
                                              movingLabel: .init(common: "Aligned with Toe", medical: "Aligned with Proximal Phalange"),
                                              normalAMA: "",
                                              normalAAOS: "",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside",
                                              defaultDotPoints: [CGPoint(x: 577, y: 1426), CGPoint(x: 570, y: 932), CGPoint(x: 776, y: 576)],
                                              labelOffsets: ["Left", "Left", "Up"]),])

let neckJoint = Joint.init(name: .init(common: "Neck", medical: "Cervical Spine"),
                           motions: [
                            MotionStruct.init(name: .init(common: "Head Forward", medical: "Flexion"),
                                              stationaryLabel: .init(common: "Vertical", medical: ""),
                                              axisLabel: .init(common: "Ear", medical: "External Auditory Meatus"),
                                              movingLabel: .init(common: "Aligned with Nostrils", medical: ""),
                                              normalAMA: "60",
                                              normalAAOS: "70.5,7.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Inside-90",
                                              defaultDotPoints:  [CGPoint(x: 748, y: 300), CGPoint(x: 760, y: 892), CGPoint(x: 923, y: 1211)],
                                                                 labelOffsets: ["Up", "Left", "Down"]),
                            MotionStruct.init(name: .init(common: "Head Back", medical: "Eversion"),
                                              stationaryLabel: .init(common: "Vertical", medical: ""),
                                              axisLabel: .init(common: "Ear", medical: "External Auditory Meatus"),
                                              movingLabel: .init(common: "Aligned with Nostrils", medical: ""),
                                              normalAMA: "75",
                                              normalAAOS: "70.5,7.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Inside",
                                              defaultDotPoints: [CGPoint(x: 609, y: 340), CGPoint(x: 610, y: 860), CGPoint(x: 790, y: 584)],
                                              labelOffsets: ["Up", "Right", "Right"]),
                            MotionStruct.init(name: .init(common: "Side Bending", medical: ""),
                                              stationaryLabel: .init(common: "Backbone", medical: "Spinous Processes of Thoracic Spine"),
                                              axisLabel: .init(common: "Neck", medical: "Spinous Process of C7"),
                                              movingLabel: .init(common: "Center of Back of Head", medical: "Posterior Midline of Head at Occipital Protuberance"),
                                              normalAMA: "45",
                                              normalAAOS: "46.5,6.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside",
                                              defaultDotPoints: [CGPoint(x: 524, y: 1224), CGPoint(x: 680, y: 770), CGPoint(x: 935, y: 558)],
                                              labelOffsets: ["Down", "Left", "Up"]),
                            MotionStruct.init(name: .init(common: "Rotation", medical: ""),
                                              stationaryLabel: .init(common: "Shoulder", medical: "Aligned with Acromion Processes"),
                                              axisLabel: .init(common: "Center Top of Head", medical: "Center of Superior Aspect of Head"),
                                              movingLabel: .init(common: "Aligned with Tip of Nose", medical: ""),
                                              normalAMA: "80",
                                              normalAAOS: "81,6.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside-90",
                                              defaultDotPoints:  [CGPoint(x: 1137, y: 982), CGPoint(x: 554, y: 937), CGPoint(x: 1001, y: 845)],
                                              labelOffsets: ["Down", "Left", "Up"]),])

let backJoint = Joint.init(name: .init(common: "Back", medical: "Thoraco-Lumber Spine"),
                           motions: [
                            MotionStruct.init(name: .init(common: "Sidebending", medical: ""),
                                              stationaryLabel: .init(common: "Vertical", medical: ""),
                                              axisLabel: .init(common: "Base of Spine", medical: "S1 Spinous Process"),
                                              movingLabel: .init(common: "Neck", medical: "C7 Spinous Process"),
                                              normalAMA: "25",
                                              normalAAOS: "27.1,6.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside",
                                              defaultDotPoints: [CGPoint(x: 529, y: 1582), CGPoint(x: 524, y: 1053), CGPoint(x: 849, y: 493)],
                                              labelOffsets: ["Down", "Left", "Right"]),
                            MotionStruct.init(name: .init(common: "Rotation", medical: ""),
                                              stationaryLabel: .init(common: "Aligned with Hip Bones", medical: "Aligned with ASISs"),
                                              axisLabel: .init(common: "Shoulder", medical: "Aligned with Acromion Processes"),
                                              movingLabel: .init(common: "Shoulder", medical: "Aligned with Acromion Processes"),
                                              normalAMA: "45",
                                              normalAAOS: "",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Inside",
                                              defaultDotPoints: [CGPoint(x: 1036, y: 786), CGPoint(x: 305, y: 801), CGPoint(x: 938, y: 1391)],
                                              labelOffsets: ["Up", "Left", "Down"]),])

let customJoint = Joint.init(name: .init(common: "Custom", medical: "Custom Measurement"),
                           motions: [
                            MotionStruct.init(name: .init(common: "Q1", medical: "first quadrant"),
                                              stationaryLabel: .init(common: "Stationary Arm", medical: ""),
                                              axisLabel: .init(common: "Axis", medical: ""),
                                              movingLabel: .init(common: "Moving Arm", medical: ""),
                                              normalAMA: "60",
                                              normalAAOS: "70.5,7.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Inside",
                                              defaultDotPoints: [CGPoint(x: 207, y: 240), CGPoint(x: 207, y: 80), CGPoint(x: 127, y: 160)],
                                              labelOffsets: ["Down", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Q2", medical: "second quadrant"),
                                              stationaryLabel: .init(common: "Stationary Arm", medical: ""),
                                              axisLabel: .init(common: "Axis", medical: ""),
                                              movingLabel: .init(common: "Moving Arm", medical: ""),
                                             normalAMA: "75",
                                              normalAAOS: "70.5,7.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Inside-90",
                                              defaultDotPoints: [CGPoint(x: 207, y: 240), CGPoint(x: 207, y: 80), CGPoint(x: 127, y: 0)],
                                              labelOffsets: ["Down", "Right", "Up"]),
                            MotionStruct.init(name: .init(common: "Q3", medical: "third quadrant"),
                                              stationaryLabel: .init(common: "Stationary Arm", medical: ""),
                                              axisLabel: .init(common: "Axis", medical: ""),
                                              movingLabel: .init(common: "Moving Arm", medical: ""),
                                              normalAMA: "45",
                                              normalAAOS: "46.5,6.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside",
                                              defaultDotPoints: [CGPoint(x: 207, y: 240), CGPoint(x: 207, y: 80), CGPoint(x: 287, y: 0)],
                                              labelOffsets: ["Down", "Left", "Up"]),
                            MotionStruct.init(name: .init(common: "Q4", medical: "fourth quadrant"),
                                              stationaryLabel: .init(common: "Stationary Arm", medical: ""),
                                              axisLabel: .init(common: "Axis", medical: ""),
                                              movingLabel: .init(common: "Moving Arm", medical: ""),
                                              normalAMA: "80",
                                              normalAAOS: "81,6.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside-90",
                                              defaultDotPoints: [CGPoint(x: 207, y: 240), CGPoint(x: 207, y: 80), CGPoint(x: 287, y: 160)],
                                              labelOffsets: ["Down", "Left", "Down"]),])



class BodyJoints {
    let joints = [customJoint, neckJoint, backJoint, shoulderJoint, elbowJoint,  forearm, wristJoint, knuckleJoint, fingerJoint, thumb, hipJoint, kneeJoint, ankleJoint, heelJoint, footJoint, toeJoint]

    //Create a managed object for this joint, motion, and side
    func newJointMotion(joint: Joint, motion: MotionStruct, side: String) -> JointMotion {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let moc =  appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "JointMotion", in: moc)!
        let jointMotion = JointMotion(entity: entity, insertInto: moc)

        jointMotion.nameCommon = joint.name.common
        jointMotion.nameMedical = joint.name.medical
        
        jointMotion.motionCommon = motion.name.common
        jointMotion.motionMedical = motion.name.medical
        
        jointMotion.stationaryLabelCommon = motion.stationaryLabel.common
        jointMotion.stationaryLabelMedical = motion.stationaryLabel.medical
        
        jointMotion.axisLabelCommon = motion.axisLabel.common
        jointMotion.axisLabelMedical = motion.axisLabel.medical
        
        jointMotion.movingLabelCommon = motion.movingLabel.common
        jointMotion.movingLabelMedical = motion.movingLabel.medical
        
        jointMotion.rotation = motion.rotation //default for right side of body
        jointMotion.insideOutside = motion.insideOutside
        
        jointMotion.side = side
        if side == "Left" {
            reverseRotation(jointMotion: jointMotion)
        }
        
        return jointMotion
    }
    
    fileprivate func reverseRotation(jointMotion: JointMotion) {
        if jointMotion.rotation == "CW" {
            jointMotion.rotation = "CCW"
        } else {
            jointMotion.rotation = "CW"
        }
    }

    fileprivate func addJoints() {
        for joint in joints {
            addJoint(joint: joint)
        }
    }
    
    func jointFromJointMotion(jointMotion: JointMotion) -> Joint {
        var joint = joints.first(where: { $0.name.common == jointMotion.nameCommon })
        if joint == nil { //If joint not found assume it is a custom joint name
            joint = joints[0] //Custom joint is first
            joint?.name.common = jointMotion.nameCommon!
        }
        return joint!
    }
    
    func motionFromJointMotion(jointMotion: JointMotion) -> MotionStruct {
        let joint = jointFromJointMotion(jointMotion: jointMotion)
        var motion = joint.motions.first(where: { $0.name.common == jointMotion.motionCommon })
        if motion == nil { //If motion not found default to the first motion
            motion = joint.motions[0]
        }
        return motion!
    }
    

    fileprivate func addJoint(joint: Joint) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext =  appDelegate.persistentContainer.viewContext

        for motion in joint.motions {
            //Create a new jointMotion object
            let entity = NSEntityDescription.entity(forEntityName: "JointMotion", in: managedContext)!
            let jointMotion = JointMotion(entity: entity, insertInto: managedContext)
            
            jointMotion.nameCommon = joint.name.common
            jointMotion.nameMedical = joint.name.medical

            jointMotion.motionCommon = motion.name.common
            jointMotion.motionMedical = motion.name.medical
            
            jointMotion.stationaryLabelCommon = motion.stationaryLabel.common
            jointMotion.stationaryLabelMedical = motion.stationaryLabel.medical
            
            jointMotion.axisLabelCommon = motion.axisLabel.common
            jointMotion.axisLabelMedical = motion.axisLabel.medical
            
            jointMotion.movingLabelCommon = motion.movingLabel.common
            jointMotion.movingLabelMedical = motion.movingLabel.medical
        }
    }
    
//    fileprivate func jointMotions() {
//        var jointData: [JointMotion] = []
//        // Our result is going to be an array of dictionaries.
//        var results:[[String:AnyObject]]?
//
//        guard let appDelegate =
//            UIApplication.shared.delegate as? AppDelegate else {
//                return
//        }
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "JointMotion")
//        let fetchRequest2 = NSFetchRequest<NSManagedObject>(entityName: "JointMotion")
//        
//        let filter = "Shoulder"
//        let predicate = NSPredicate(format: "nameCommon = %@", filter)
//        fetchRequest.predicate = predicate
//        fetchRequest.resultType = .dictionaryResultType
//        fetchRequest.propertiesToFetch = ["motionCommon", "motionMedical"]
//
//        do {
//            results = try managedContext.fetch(fetchRequest) as? [[String : AnyObject]]
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//        
//    }
    
//    Printing description of results:
//    ▿ Optional<Array<Dictionary<String, AnyObject>>>
//    ▿ some : 2 elements
//    ▿ 0 : 2 elements
//    ▿ 0 : 2 elements
//    - key : "motionMedical"
//    - value : Extension
//    ▿ 1 : 2 elements
//    - key : "motionCommon"
//    - value : Arm Reverse Raise
//    ▿ 1 : 2 elements
//    ▿ 0 : 2 elements
//    - key : "motionMedical"
//    - value : Flexion
//    ▿ 1 : 2 elements
//    - key : "motionCommon"
//    - value : Arm Raise



}




