//
//  PersistencyManager.swift
//  bodyflex
//
//  Created by Steven Gallagher on 1/4/18.
//  Copyright © 2018 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

final class PersistencyManager {
    private var measurements = [NSManagedObject]()

    func getMeasurements() -> [NSManagedObject] {
        return measurements
    }
    
    func addMeasurement(_ measurement: NSManagedObject, at index: Int) {
        if (measurements.count >= index) {
            measurements.insert(measurement, at: index)
        } else {
            measurements.append(measurement)
        }
    }
    
    func deleteMeasurement(at index: Int) {
        measurements.remove(at: index)
    }
}
