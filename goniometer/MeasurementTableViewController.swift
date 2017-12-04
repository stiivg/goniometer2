//
//  MeasurementTableViewController.swift
//  goniometer
//
//  Created by Steven Gallagher on 11/22/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

class MeasurementTableViewController: UITableViewController {

    // MARK: - Properties
    var measurements: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Measurement")
        
        //3
        do {
            measurements = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        //TEMP to clear core data
        
//        for bas: AnyObject in measurements
//        {
//            managedContext.delete(bas as! NSManagedObject)
//        }
//
//        measurements.removeAll(keepingCapacity: false)
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - IBActions
    
    @IBAction func cancelToMeasurementsViewController(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveMeasurementsDetail(_ segue: UIStoryboardSegue) {
        guard let measurementDetailsViewController = segue.source as? AddMeasurementViewController,
            let measurementValues = measurementDetailsViewController.measurement else {
                return
        }
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Measurement", in: managedContext)!
        
        let measurement = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // 3
        measurement.setValue(measurementValues.name, forKeyPath: "name")
        measurement.setValue(measurementValues.joint, forKeyPath: "joint")
        measurement.setValue(measurementValues.motion, forKeyPath: "motion")
        measurement.setValue(measurementValues.side, forKeyPath: "side")
        measurement.setValue(measurementValues.angle, forKeyPath: "angle")
        
        let dateString = measurementValues.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let dateObj = dateFormatter.date(from: dateString!)

        measurement.setValue(dateObj, forKeyPath: "date")

        // 4
        do {
            try managedContext.save()
            measurements.append(measurement)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
         // update the tableView
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return measurements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeasurementCell", for: indexPath) as! MeasurementCell
        
        if measurements.count > 0 {
            let measurement = measurements[indexPath.row]
            cell.measurement = measurement
        }
        return cell

 
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
