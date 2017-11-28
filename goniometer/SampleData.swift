//
//  SampleData.swift
//  goniometer
//
//  Created by Steven Gallagher on 11/22/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import Foundation

final class SampleData {
    
    static func generateMeasurementsData() -> [Measurement] {
        return [
            Measurement(name: "Lana", joint: "Knee", side: "Left", direction: "Flexion", angle: 143, date: "10/21/17"),
            Measurement(name: "Lana", joint: "Elbow", side: "Right", direction: "Flexion", angle: 145, date: "11/3/17"),
            Measurement(name: "Lana", joint: "Arm", side: "Left", direction: "Flexion", angle: 146, date: "11/17/17"),
        ]
    }
}
