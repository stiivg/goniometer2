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
//        clearCoreDate()
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clearCoreDate() {
        clearAllFullRes()
        clearAllMeasurments()
    }
    
    func clearAllFullRes() {
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
    
    func clearAllMeasurments() {
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
    
    // MARK: - IBActions

    @IBAction func cancelToMeasurementsViewController(_ segue: UIStoryboardSegue) {
        // update the tableView
        self.tableView.reloadData()
    }
    
    @IBAction func cancelMeasurementEdit(_ segue: UIStoryboardSegue) {
    }
    
    // Return from creating new measurement
    @IBAction func saveMeasurementEdit(_ segue: UIStoryboardSegue) {
        //Notify the edit view to complete all edits
        let addMeasurementViewController = segue.source as? AddMeasurementViewController
        addMeasurementViewController?.completeEdit()
        
        guard let measurementDetailsViewController = segue.source as? AddMeasurementViewController,
            let measurement = measurementDetailsViewController.measurement else {
                return
        }
        
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "ListToAddMeasurement" {
            let nav = segue.destination as! UINavigationController
            let addMeasurementViewController = nav.topViewController as? AddMeasurementViewController
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            
            //Create a new measurement object
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Measurement", in: managedContext)!
            let measurement = NSManagedObject(entity: entity, insertInto: managedContext)
            
            // Pass a new object to the addMeasurement view controller.
            addMeasurementViewController?.measurement = measurement
        }
        
        if segue.identifier == "CellToSingleMeasurement" {
            let nav = segue.destination as! UINavigationController
            let singleViewController = nav.topViewController as? SingleMeasurementViewController
            
            let mCell = sender as? MeasurementCell
            // Pass the selected object to the new view controller.
            singleViewController?.measurement = mCell?.measurement
        }
    }

    
    
    
    
    
    
    
    
    
    
}
