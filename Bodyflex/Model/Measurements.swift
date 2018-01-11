//
//  Measurements.swift
//  bodyflex
//
//  Created by Steven Gallagher on 1/4/18.
//  Copyright © 2018 Steven Gallagher. All rights reserved.
//


import UIKit
import CoreData

//A singleton class to contain the measurement data
final class MeasurementsAPI {
    private let moc: NSManagedObjectContext

    static let shared =  MeasurementsAPI()
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        moc = appDelegate.persistentContainer.viewContext
    }
    
    func getMeasurements() -> [Measurement] {
        var measurements: [Measurement]
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Measurement")

        do {
            measurements = try moc.fetch(fetchRequest) as! [Measurement]
        } catch let error as NSError {
            let entity = NSEntityDescription.entity(forEntityName: "Measurement", in: moc)!
            let defaultMeasurement = Measurement.init(entity: entity, insertInto: moc)
            measurements = [defaultMeasurement] //Should never be used: required to compile

            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return measurements
    }
    
    func newMeasurement() -> Measurement {
        
        //Create a new measurement object
        let entity = NSEntityDescription.entity(forEntityName: "Measurement", in: moc)!
        let measurement = NSManagedObject(entity: entity, insertInto: moc) as! Measurement

        //Create a new jointMotion object
        let jointMotionEntity = NSEntityDescription.entity(forEntityName: "JointMotion", in: moc)!
        let jointMotion = NSManagedObject(entity: jointMotionEntity, insertInto: moc) as! JointMotion
        
        //set link to jointMotion
        measurement.jointMotion = jointMotion

        return measurement
    }
    
    func saveMeasurement() {
        do {
            try moc.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //Note not saved so can be rolled back
    func deleteJointMotion(measurement: NSManagedObject) {
        let jointMotionEntity = measurement.value(forKey: "jointMotion") as? NSManagedObject
        
        if jointMotionEntity != nil {
            moc.delete(jointMotionEntity!)
        }
    }
    
    //Note not saved so can be rolled back
    func deleteFullRes(measurement: NSManagedObject) {
        let fullResEntity = measurement.value(forKey: "fullRes") as? NSManagedObject
        
        if fullResEntity != nil {
            moc.delete(fullResEntity!)
        }
    }
    
    func deleteMeasurement(measurement: NSManagedObject) {
        self.deleteFullRes(measurement: measurement)
        self.deleteJointMotion(measurement: measurement)
        moc.delete(measurement)
    }
    
    func cancelMeasurementEdit() {
        moc.rollback() // Undo any edits
    }
    
    fileprivate func clearCoreDate() {
        clearAllFullRes()
        clearAllMeasurements()
    }
    
    fileprivate func clearAllFullRes() {
        var fullResList: [NSManagedObject] = []
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FullRes")
        
        do {
            fullResList = try moc.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for bas: AnyObject in fullResList
        {
            moc.delete(bas as! NSManagedObject)
        }
        
        fullResList.removeAll(keepingCapacity: false)
        
        self.saveMeasurement()
        
    }
    
    fileprivate func clearAllMeasurements() {
        var measurements = self.getMeasurements()

        for bas: AnyObject in measurements
        {
            moc.delete(bas as! NSManagedObject)
        }
        
        measurements.removeAll(keepingCapacity: false)
        
        self.saveMeasurement()
        
    }
    
}
