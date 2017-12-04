//
//  MeasurementDetailsViewController.swift
//  goniometer
//
//  Created by Steven Gallagher on 11/22/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit

class AddMeasurementViewController: UITableViewController {

   
    // MARK: - Properties
    var measurement: MeasurementStruct?
    
    var joint: String = "Knee" {
        didSet {
            jointLabel.text = joint
        }
    }
    var motion: String = "Flexion" {
        didSet {
            motionLabel.text = motion
        }
    }

    var side: String = "Right" {
        didSet {
            var index = 0  //assume Left
            if side == "Right" {
                index = 1
            }
            sideControl.selectedSegmentIndex = index
        }
    }

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var jointLabel: UILabel!
    @IBOutlet weak var motionLabel: UILabel!
    @IBOutlet weak var sideControl: UISegmentedControl!
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "SaveMeasurementDetail",
            let name = nameTextField.text {
            measurement = MeasurementStruct(name: name, joint: joint, side: side, motion: motion, angle: 142, date: "10-13-2017")
        }
        if segue.identifier == "PickJoint",
            let jointPickerViewController = segue.destination as? JointPickerViewController {
            jointPickerViewController.selectedJoint = joint
        }
        if segue.identifier == "PickDirection",
            let motionPickerViewController = segue.destination as? MotionPickerViewController {
            motionPickerViewController.selectedMotion = motion
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        side = "Right" //initialize the default value
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - IBActions
extension AddMeasurementViewController {
    //MARK Actions
    @IBAction func cancelToMeasurementDetailsViewController(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveMeasurementDetail(_ segue: UIStoryboardSegue) {
    }

    
    @IBAction func sideControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            side = "Left"
        } else {
            side = "Right"
        }
    }

    @IBAction func unwindWithSelectedJoint(segue: UIStoryboardSegue) {
        if let jointPickerViewController = segue.source as? JointPickerViewController,
            let selectedJoint = jointPickerViewController.selectedJoint {
            joint = selectedJoint
        }
    }
    @IBAction func unwindWithSelectedDirection(segue: UIStoryboardSegue) {
        if let motionPickerViewController = segue.source as? MotionPickerViewController,
            let selectedDirection = motionPickerViewController.selectedMotion {
            motion = selectedDirection
        }
    }
}

// MARK: - UITableViewDelegate
extension AddMeasurementViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
    }
}
