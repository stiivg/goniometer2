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
    let common: String
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
    let name: NameType
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
                                    rotation: "CW",
                                    insideOutside: "Inside",
                                    defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                    labelOffsets: ["Up", "Up", "Up"]),
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
                                    defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                    labelOffsets: ["Up", "Up", "Up"]),
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
                                    defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                    labelOffsets: ["Up", "Up", "Up"]),
                                MotionStruct.init(name: .init(common: "Bent Arm Lower", medical: "Medial Rotation"),
                                    stationaryLabel: .init(common: "Vertical", medical: ""),
                                    axisLabel: .init(common: "Elbow", medical: "Olecranon Process"),
                                    movingLabel: .init(common: "Wrist", medical: "Ulnar Styloid"),
                                    normalAMA: "90",
                                    normalAAOS: "69,4.6",
                                    position: "",
                                    description: "",
                                    rotation: "CW",
                                    insideOutside: "Inside",
                                    defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                    labelOffsets: ["Up", "Up", "Up"]),
                                MotionStruct.init(name: .init(common: "Bent Arm Raise", medical: "Lateral Rotation"),
                                    stationaryLabel: .init(common: "Vertical", medical: ""),
                                    axisLabel: .init(common: "Elbow", medical: "Olecranon Process"),
                                    movingLabel: .init(common: "Wrist", medical: "Ulnar Styloid"),
                                    normalAMA: "90",
                                    normalAAOS: "104,8.5",
                                    position: "",
                                    description: "",
                                    rotation: "CW",
                                    insideOutside: "Inside",
                                    defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
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
                                rotation: "CW",
                                insideOutside: "Outside",
                                defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                labelOffsets: ["Up", "Up", "Up"]),
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
                                defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                labelOffsets: ["Up", "Up", "Up"])
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
                                                       description: "Turn lower palm so arm faces up",
                                                       rotation: "CW",
                                                       insideOutside: "Inside",
                                                       defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                       labelOffsets: ["Up", "Up", "Up"]),
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
                                                       defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                       labelOffsets: ["Up", "Up", "Up"]),])

let wristJoint = Joint.init(name: .init(common: "Wrist", medical: ""),
                         motions: [
                            MotionStruct.init(name: .init(common: "Hand Lowered", medical: "Flexion"),
                                                   stationaryLabel: .init(common: "Parallel to Lower Arm", medical: "Ulna"),
                                                   axisLabel: .init(common: "Wrist", medical: "Triquetum"),
                                                   movingLabel: .init(common: "Hand", medical: "5th Metacarpal"),
                                                   normalAMA: "60",
                                                   normalAAOS: "75,6.6",
                                                   position: "",
                                                   description: "",
                                                   rotation: "CW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                   labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Hand Raised", medical: "Extension"),
                                                   stationaryLabel: .init(common: "Parallel to Lower Arm", medical: "Ulna"),
                                                   axisLabel: .init(common: "Wrist", medical: "Triquetum"),
                                                   movingLabel: .init(common: "Hand", medical: "5th Metacarpal"),
                                                   normalAMA: "60",
                                                   normalAAOS: "74,6.6",
                                                   position: "",
                                                   description: "",
                                                   rotation: "CW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                   labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Hand Out", medical: "Radial Deviation"),
                                                   stationaryLabel: .init(common: "Elbow", medical: "Lateral Epicondyle"),
                                                   axisLabel: .init(common: "Wrist", medical: "Capitate"),
                                                   movingLabel: .init(common: "Middle Finger", medical: "Middle Metacarpal"),
                                                   normalAMA: "20",
                                                   normalAAOS: "21,4.0",
                                                   position: "",
                                                   description: "",
                                                   rotation: "CW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                   labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Hand In", medical: "Ulnar Deviation"),
                                                   stationaryLabel: .init(common: "Elbow", medical: "Lateral Epicondyle"),
                                                   axisLabel: .init(common: "Wrist", medical: "Capitate"),
                                                   movingLabel: .init(common: "Middle Finger", medical: "Middle Metacarpal"),
                                                   normalAMA: "30",
                                                   normalAAOS: "35,3.8",
                                                   position: "",
                                                   description: "",
                                                   rotation: "CW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                   labelOffsets: ["Up", "Up", "Up"]),])

let knuckleJoint = Joint.init(name: .init(common: "Knuckle", medical: "Metacarpophalangeal"),
                              motions: [
                                MotionStruct.init(name: .init(common: "Lower Fingers", medical: "Flexion"),
                                                       stationaryLabel: .init(common: "Back of Hand", medical: "Aligned with Metacarpal"),
                                                       axisLabel: .init(common: "Knuckle", medical: "Dorsal Metacarpophalangeal Joint"),
                                                       movingLabel: .init(common: "Finger", medical: "Aligned with Proximal Phalange"),
                                                       normalAMA: "90",
                                                       normalAAOS: "86",
                                                       position: "",
                                                       description: "",
                                                       rotation: "CW",
                                                       insideOutside: "Outside",
                                                       defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                       labelOffsets: ["Up", "Up", "Up"]),
                                MotionStruct.init(name: .init(common: "Raise Fingers", medical: "Extension"),
                                                       stationaryLabel: .init(common: "Back of Hand", medical: "Aligned with Metacarpal"),
                                                       axisLabel: .init(common: "Knuckle", medical: "Dorsal Metacarpophalangeal Joint"),
                                                       movingLabel: .init(common: "Finger", medical: "Aligned with Proximal Phalange"),
                                                       normalAMA: "20",
                                                       normalAAOS: "22",
                                                       position: "",
                                                       description: "",
                                                       rotation: "CW",
                                                       insideOutside: "Outside",
                                                       defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                       labelOffsets: ["Up", "Up", "Up"]),
                                MotionStruct.init(name: .init(common: "Separate Fingers", medical: "Abduction"),
                                                       stationaryLabel: .init(common: "Back of Hand", medical: "Aligned with Metacarpal"),
                                                       axisLabel: .init(common: "Knuckle", medical: "Dorsal Metacarpophalangeal Joint"),
                                                       movingLabel: .init(common: "Finger", medical: "Aligned with Proximal Phalange"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
                                                       position: "",
                                                       description: "",
                                                       rotation: "CW",
                                                       insideOutside: "Outside",
                                                       defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                       labelOffsets: ["Up", "Up", "Up"]),
                                MotionStruct.init(name: .init(common: "Fingers from Thumb", medical: "Adduction"),
                                                       stationaryLabel: .init(common: "Back of Hand", medical: "Aligned with Metacarpal"),
                                                       axisLabel: .init(common: "Knuckle", medical: "Dorsal Metacarpophalangeal Joint"),
                                                       movingLabel: .init(common: "Finger", medical: "Aligned with Proximal Phalange"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
                                                       position: "",
                                                       description: "",
                                                       rotation: "CW",
                                                       insideOutside: "Outside",
                                                       defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                       labelOffsets: ["Up", "Up", "Up"]),])

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
                                    rotation: "CW",
                                    insideOutside: "Outside",
                                    defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                    labelOffsets: ["Up", "Up", "Up"]),
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
                                    defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                    labelOffsets: ["Up", "Up", "Up"]),])

let thumb = Joint.init(name: .init(common: "Thumb", medical: "Thumb Carpometacarpal"),
                             motions: [
                                MotionStruct.init(name: .init(common: "Thumb In", medical: "Flexion"),
                                                       stationaryLabel: .init(common: "Aligned with Arm", medical: "Aligned with Radius"),
                                                       axisLabel: .init(common: "Wrist", medical: "Carpometacarpal Joint"),
                                                       movingLabel: .init(common: "Base of Thumb", medical: "Thumb Metacarpal"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
                                                       position: "",
                                                       description: "",
                                                       rotation: "CW",
                                                       insideOutside: "Outside",
                                                       defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                       labelOffsets: ["Up", "Up", "Up"]),
                                MotionStruct.init(name: .init(common: "Thumb Out", medical: "Extension"),
                                                       stationaryLabel: .init(common: "Aligned with Arm", medical: "Aligned with Radius"),
                                                       axisLabel: .init(common: "Wrist", medical: "Carpometacarpal Joint"),
                                                       movingLabel: .init(common: "Base of Thumb", medical: "Thumb Metacarpal"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
                                                       position: "",
                                                       description: "",
                                                       rotation: "CW",
                                                       insideOutside: "Outside",
                                                       defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                       labelOffsets: ["Up", "Up", "Up"]),
                                MotionStruct.init(name: .init(common: "Thumb Down", medical: "Abduction"),
                                                       stationaryLabel: .init(common: "Finger", medical: "Finger Metacarpal"),
                                                       axisLabel: .init(common: "Wrist", medical: "Radial Styloid"),
                                                       movingLabel: .init(common: "Base of Thumb", medical: "Thumb Metacarpal"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
                                                       position: "",
                                                       description: "",
                                                       rotation: "CW",
                                                       insideOutside: "Inside",
                                                       defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                       labelOffsets: ["Up", "Up", "Up"]),
                                MotionStruct.init(name: .init(common: "Thumb Down", medical: "Adduction"),
                                                       stationaryLabel: .init(common: "Finger", medical: "Finger Metacarpal"),
                                                       axisLabel: .init(common: "Wrist", medical: "Radial Styloid"),
                                                       movingLabel: .init(common: "Base of Thumb", medical: "Thumb Metacarpal"),
                                                       normalAMA: "",
                                                       normalAAOS: "",
                                                       position: "",
                                                       description: "",
                                                       rotation: "CW",
                                                       insideOutside: "Inside",
                                                       defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                       labelOffsets: ["Up", "Up", "Up"]),])

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
                                                   rotation: "CW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                   labelOffsets: ["Up", "Up", "Up"]),
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
                                                   defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                   labelOffsets: ["Up", "Up", "Up"]),
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
                                                   defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                   labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Leg In", medical: "Lateral (External) Rotation"),
                                                   stationaryLabel: .init(common: "Aligned Vertically", medical: ""),
                                                   axisLabel: .init(common: "Knee", medical: "Center of Patella"),
                                                   movingLabel: .init(common: "Ankle", medical: "Crest of Tibia"),
                                                   normalAMA: "50",
                                                   normalAAOS: "44,4.8",
                                                   position: "",
                                                   description: "",
                                                   rotation: "CW",
                                                   insideOutside: "Inside",
                                                   defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
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
                                                   defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                   labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Straighten", medical: "Extension"),
                                                   stationaryLabel: .init(common: "Hip Bone", medical: "Greater Trochanter"),
                                                   axisLabel: .init(common: "Knee", medical: "Lateral Epicondyle"),
                                                   movingLabel: .init(common: "Ankle", medical: "Lateral Malleolus"),
                                                   normalAMA: "0", //Guessed
                                                   normalAAOS: "0,10", //Guessed
                                                   position: "",
                                                   description: "",
                                                   rotation: "CW",
                                                   insideOutside: "Outside",
                                                   defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                   labelOffsets: ["Up", "Up", "Up"]),])

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
                                                   rotation: "CW",
                                                   insideOutside: "Outside-90",
                                                   defaultDotPoints: [CGPoint(x: 745, y: 346), CGPoint(x: 770, y: 1136), CGPoint(x: 981, y: 1405)],
                                                   labelOffsets: ["Right", "Up", "Up"]),
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
                                                   labelOffsets: ["Up", "Up", "Up"]),])

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
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Rotate In", medical: "Eversion"),
                                              stationaryLabel: .init(common: "Midline of Leg", medical: ""),
                                              axisLabel: .init(common: "", medical: ""),
                                              movingLabel: .init(common: "Aligned with Sole", medical: "Aligned with Plantar Aspect of Metatarsal Heads"),
                                              normalAMA: "",
                                              normalAAOS: "",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside-90",
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),])

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
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Lower", medical: "Plantarflexion"),
                                              stationaryLabel: .init(common: "Ankle", medical: "Aligned to Metatarsal"),
                                              axisLabel: .init(common: "Base of Toe", medical: "Medial to Center of Metararsal Head"),
                                              movingLabel: .init(common: "Aligned with Toe", medical: "Aligned with Proximal Phalange"),
                                              normalAMA: "30",
                                              normalAAOS: "",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside",
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Out", medical: "Abduction"),
                                              stationaryLabel: .init(common: "Aligned with Foot", medical: "Aligned to Metatarsal"),
                                              axisLabel: .init(common: "Base of Toe", medical: "Center of Metararsal Head"),
                                              movingLabel: .init(common: "Aligned with Toe", medical: "Aligned with Proximal Phalange"),
                                              normalAMA: "",
                                              normalAAOS: "",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside",
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),
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
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),])

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
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                                                 labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Head Back", medical: "Eversion"),
                                              stationaryLabel: .init(common: "Vertical", medical: ""),
                                              axisLabel: .init(common: "Ear", medical: "External Auditory Meatus"),
                                              movingLabel: .init(common: "Aligned with Nostrils", medical: ""),
                                              normalAMA: "75",
                                              normalAAOS: "70.5,7.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside-90",
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),
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
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),
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
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),])

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
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "Rotation", medical: ""),
                                              stationaryLabel: .init(common: "Aligned with Hip Bones", medical: "Aligned with ASISs"),
                                              axisLabel: .init(common: "Center Top of Head", medical: "Center of Superior Aspect of Head"),
                                              movingLabel: .init(common: "Shoulder", medical: "Aligned with Acromion Processes"),
                                              normalAMA: "45",
                                              normalAAOS: "",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside-90",
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),])

let testJoint = Joint.init(name: .init(common: "Test", medical: "Cervical Spine"),
                           motions: [
                            MotionStruct.init(name: .init(common: "Inside-90 CW Q90", medical: "Flexion"),
                                              stationaryLabel: .init(common: "Vertical", medical: ""),
                                              axisLabel: .init(common: "Ear", medical: "External Auditory Meatus"),
                                              movingLabel: .init(common: "Aligned with Nostrils", medical: ""),
                                              normalAMA: "60",
                                              normalAAOS: "70.5,7.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Inside-90",
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "CW Outside-90 Q270", medical: "Eversion"),
                                              stationaryLabel: .init(common: "Vertical", medical: ""),
                                              axisLabel: .init(common: "Ear", medical: "External Auditory Meatus"),
                                              movingLabel: .init(common: "Aligned with Nostrils", medical: ""),
                                              normalAMA: "75",
                                              normalAAOS: "70.5,7.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside-90",
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "CW Outside Q180", medical: ""),
                                              stationaryLabel: .init(common: "Backbone", medical: "Spinous Processes of Thoracic Spine"),
                                              axisLabel: .init(common: "Neck", medical: "Spinous Process of C7"),
                                              movingLabel: .init(common: "Center of Back of Head", medical: "Posterior Midline of Head at Occipital Protuberance"),
                                              normalAMA: "45",
                                              normalAAOS: "46.5,6.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Outside",
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),
                            MotionStruct.init(name: .init(common: "CW Inside Q0", medical: ""),
                                              stationaryLabel: .init(common: "Shoulder", medical: "Aligned with Acromion Processes"),
                                              axisLabel: .init(common: "Center of Top of Head", medical: "Center of Superior Aspect of Head"),
                                              movingLabel: .init(common: "Aligned with Tip of Nose", medical: ""),
                                              normalAMA: "80",
                                              normalAAOS: "81,6.5",
                                              position: "",
                                              description: "",
                                              rotation: "CW",
                                              insideOutside: "Inside",
                                              defaultDotPoints: [CGPoint(x: 100, y: 300), CGPoint(x: 100, y: 200), CGPoint(x: 150, y: 200)],
                                              labelOffsets: ["Up", "Up", "Up"]),])



class BodyJoints {
    let joints = [testJoint, neckJoint, backJoint, shoulderJoint, elbowJoint,  forearm, wristJoint, knuckleJoint, fingerJoint, thumb, hipJoint, kneeJoint, ankleJoint, heelJoint, footJoint, toeJoint]

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
        
        jointMotion.rotation = motion.rotation //default for left side of body
        jointMotion.insideOutside = motion.insideOutside
        
        jointMotion.side = side
        if side == "Right" {
            reverseRotation(jointMotion: jointMotion)
        }
        
        return jointMotion
    }
    
    fileprivate func reverseRotation(jointMotion: JointMotion) {
        if jointMotion.rotation == "CW" {
            jointMotion.rotation = "CW"
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
        if joint == nil { //If joint not found default to the first joint
            joint = joints[0]
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
    
    fileprivate func jointMotions() {
        var jointData: [JointMotion] = []
        // Our result is going to be an array of dictionaries.
        var results:[[String:AnyObject]]?

        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "JointMotion")
        let fetchRequest2 = NSFetchRequest<NSManagedObject>(entityName: "JointMotion")
        
        let filter = "Shoulder"
        let predicate = NSPredicate(format: "nameCommon = %@", filter)
        fetchRequest.predicate = predicate
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.propertiesToFetch = ["motionCommon", "motionMedical"]

        do {
            results = try managedContext.fetch(fetchRequest) as? [[String : AnyObject]]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
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




