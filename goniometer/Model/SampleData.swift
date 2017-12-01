//
//  SampleData.swift
//  goniometer
//
//  Created by Steven Gallagher on 11/22/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import Foundation

final class SampleData {
    
    static func generateMeasurementsData() -> [MeasurementStruct] {
        return [
            MeasurementStruct(name: "Lana", joint: "Knee", side: "Left", motion: "Flexion", angle: 143, date: "10/21/17"),
            MeasurementStruct(name: "Lana", joint: "Elbow", side: "Right", motion: "Flexion", angle: 145, date: "11/3/17"),
            MeasurementStruct(name: "Lana", joint: "Arm", side: "Left", motion: "Flexion", angle: 146, date: "11/17/17"),
        ]
    }
}
