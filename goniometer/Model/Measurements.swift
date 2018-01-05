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
    
    private var measurements = [NSManagedObject]()

    static let shared =  MeasurementsAPI()
    
    private init() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Measurement")
        
        do {
            measurements = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func getMeasurements() -> [NSManagedObject] {
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
    
    func addMeasurement(measurement: NSManagedObject) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =  appDelegate.persistentContainer.viewContext
        
        do {
            try managedContext.save()
            measurements.append(measurement)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteMeasurement(at index: Int) {
    }
    
    func cancelMeasurementEdit() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =  appDelegate.persistentContainer.viewContext
        managedContext.rollback() // Undo any edits
    }
    
    fileprivate func clearCoreDate() {
        clearAllFullRes()
        clearAllMeasurements()
    }
    
    fileprivate func clearAllFullRes() {
        var fullResList: [NSManagedObject] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FullRes")
        
        do {
            fullResList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for bas: AnyObject in fullResList
        {
            managedContext.delete(bas as! NSManagedObject)
        }
        
        fullResList.removeAll(keepingCapacity: false)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    fileprivate func clearAllMeasurements() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Measurement")
        
        do {
            measurements = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for bas: AnyObject in measurements
        {
            managedContext.delete(bas as! NSManagedObject)
        }
        
        measurements.removeAll(keepingCapacity: false)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
}
