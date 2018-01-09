//
//  MeasurementTableViewController.swift
//  bodyflex
//
//  Created by Steven Gallagher on 11/22/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

class MeasurementTableViewController: UITableViewController {

    // MARK: - Properties
    var allMeasurements = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        allMeasurements = MeasurementsAPI.shared.getMeasurements()

        
        //TEMP to clear core data
//        clearCoreDate()
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions

    @IBAction func cancelToMeasurementsViewController(_ segue: UIStoryboardSegue) {
        // update the tableView
        self.tableView.reloadData()
        //TODO scroll to the current measurement in the collection
    }
    
    @IBAction func cancelMeasurementEdit(_ segue: UIStoryboardSegue) {
        MeasurementsAPI.shared.cancelMeasurementEdit()
    }
    
    // Return from creating new measurement
    @IBAction func saveMeasurementEdit(_ segue: UIStoryboardSegue) {
        //Notify the edit view to complete all edits
        let measureAngleViewController = segue.source as! MeasureAngleViewController
        measureAngleViewController.completeEdit()
        
        MeasurementsAPI.shared.saveMeasurement()
        
         // update the tableView
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMeasurements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeasurementCell", for: indexPath) as! MeasurementCell
        
        if allMeasurements.count > 0 {
            let measurement = allMeasurements[indexPath.row]
            cell.measurement = measurement
        }
        return cell

 
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let measurement = allMeasurements[indexPath.row]
            MeasurementsAPI.shared.deleteMeasurement(measurement: measurement)
            allMeasurements = MeasurementsAPI.shared.getMeasurements()

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
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
            let measureAngleViewController = nav.topViewController as! MeasureAngleViewController
            
            let newMeasurement = MeasurementsAPI.shared.newMeasurement()
            // Pass a new object to the addMeasurement view controller.
            measureAngleViewController.measurement = newMeasurement
        }
        
        if segue.identifier == "CellToSingleMeasurement" {
            let indexPath = self.tableView.indexPathForSelectedRow
            
            let nav = segue.destination as! UINavigationController
            let mCollectionView = nav.topViewController as! MeasurementCollectionViewController
            mCollectionView.displayIndex = indexPath!
        }
    }

    
    
    
    
    
    
    
    
    
    
}
