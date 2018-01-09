//
//  Measurements.swift
//  goniometer
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
    
    func getMeasurements() -> [NSManagedObject] {
        var measurements = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Measurement")
        
        do {
            measurements = try moc.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return measurements
    }
    
    func newMeasurement() -> NSManagedObject {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        //Create a new measurement object
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Measurement", in: managedContext)!
        let measurement = NSManagedObject(entity: entity, insertInto: managedContext)

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
    func deleteFullRes(measurement: NSManagedObject) {
        let fullResEntity = measurement.value(forKey: "fullRes") as? NSManagedObject
        
        if fullResEntity != nil {
            moc.delete(fullResEntity!)
        }
    }
    
    func deleteMeasurement(measurement: NSManagedObject) {
        self.deleteFullRes(measurement: measurement)
        moc.delete(measurement)
        self.saveMeasurement()
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
