//
//  SelectJointViewController.swift
//  bodyflex
//
//  Created by Steven Gallagher on 11/22/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

class SelectJointViewController: UITableViewController {

   
    // MARK: - Properties
    var measurement = Measurement()
    
    var side: String = "Right" {
        didSet {
            var index = 0  //assume Left
            if side == "Right" {
                index = 1
            }
            sideControl.selectedSegmentIndex = index
        }
    }
    
    @IBOutlet weak var jointLabel: UILabel!
    @IBOutlet weak var motionLabel: UILabel!
    @IBOutlet weak var sideControl: UISegmentedControl!
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "AddToAngleMeasure" {
            let nav = segue.destination as! UINavigationController
            let measureAngleViewController = nav.topViewController as? MeasureAngleViewController
            
            // Pass the selected object to the new view controller.
            measureAngleViewController?.setMeasurement(newMeasurement: measurement)
        }
        if segue.identifier == "PickJoint",
            let jointPickerViewController = segue.destination as? JointPickerViewController {
            jointPickerViewController.selectedJoint = measurement.joint
        }
        if segue.identifier == "PickMotion",
            let motionPickerViewController = segue.destination as? MotionPickerViewController {
            motionPickerViewController.selectedMotion = measurement.motion
        }
        //Save edit now so update on return has edited value
        completeEdit()
    }
    
    func updateValues() {
        jointLabel.text = measurement.joint
        side = measurement.side!
        motionLabel.text = measurement.motion
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        updateValues()
    }
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //Save last edit to name field
    func completeEdit() {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    
}
// MARK: - IBActions
extension SelectJointViewController {


    @IBAction func sideControl(_ sender: UISegmentedControl) {
        var sideText = "Right"
        if sender.selectedSegmentIndex == 0 {
            sideText = "Left"
        }
        measurement.side = sideText
    }

    @IBAction func unwindWithSelectedJoint(segue: UIStoryboardSegue) {
        if let jointPickerViewController = segue.source as? JointPickerViewController,
            let selectedJoint = jointPickerViewController.selectedJoint {
            measurement.joint = selectedJoint
        }
    }
    @IBAction func unwindWithSelectedDirection(segue: UIStoryboardSegue) {
        if let motionPickerViewController = segue.source as? MotionPickerViewController,
            let selectedMotion = motionPickerViewController.selectedMotion {
            measurement.motion = selectedMotion
        }
    }
}

