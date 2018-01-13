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
    var bodyJoints = BodyJoints()

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
    
    func newJointMotion(joint: Joint, motion: MotionStruct, side: String) -> JointMotion {
        let jointMotion = bodyJoints.newJointMotion(joint: joint, motion: motion, side: side)
        return jointMotion
    }
    
    func newMeasurement() -> Measurement {
        
        //Create a new measurement object
        let entity = NSEntityDescription.entity(forEntityName: "Measurement", in: moc)!
        let measurement = NSManagedObject(entity: entity, insertInto: moc) as! Measurement

        //Create a new jointMotion object, default to first knee motion
        let jointMotion = bodyJoints.newJointMotion(joint: kneeJoint, motion: kneeJoint.motions[0], side: "Left")
        
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
    
//    func deleteJointMotion(jointMotion: JointMotion) {
//        moc.delete(jointMotion)
//    }

    //Note not saved so can be rolled back
    func deleteJointMotion(measurement: NSManagedObject) {
        guard let jointMotionEntity = measurement.value(forKey: "jointMotion") as? NSManagedObject else { return }
            moc.delete(jointMotionEntity)
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
