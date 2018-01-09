//
//  MeasurementDetailsViewController.swift
//  bodyflex
//
//  Created by Steven Gallagher on 11/22/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

class AddMeasurementViewController: UITableViewController {

   
    // MARK: - Properties
    var measurement: NSManagedObject?
    
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
    @IBOutlet weak var imageView: UIImageView!
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "AddToAngleMeasure" {
            let nav = segue.destination as! UINavigationController
            let measureAngleViewController = nav.topViewController as? MeasureAngleViewController
            
            // Pass the selected object to the new view controller.
            measureAngleViewController?.measurement = measurement
        }
        if segue.identifier == "PickJoint",
            let jointPickerViewController = segue.destination as? JointPickerViewController {
            jointPickerViewController.selectedJoint = measurement?.value(forKeyPath: "joint") as? String
        }
        if segue.identifier == "PickMotion",
            let motionPickerViewController = segue.destination as? MotionPickerViewController {
            motionPickerViewController.selectedMotion = measurement?.value(forKeyPath: "motion") as? String
        }
        //Save edit now so update on return has edited value
        completeEdit()
    }
    
    func updateValues() {
        guard let measurement = measurement else { return }
        
        let name = measurement.value(forKeyPath: "name") as? String
        nameTextField.text = name
        jointLabel.text = measurement.value(forKeyPath: "joint") as? String
        side = (measurement.value(forKeyPath: "side") as? String)!
        motionLabel.text = measurement.value(forKeyPath: "motion") as? String
        
        //display the image
        if let imageData = measurement.value(forKey: "thumbnail") {
            let testImage = UIImage(data: imageData as! Data)
            imageView.image = testImage
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let dateObj = measurement.value(forKeyPath: "date") as? Date
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
        let newName = nameTextField.text
        measurement?.setValue(newName, forKey: "name")
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
extension AddMeasurementViewController {


    @IBAction func sideControl(_ sender: UISegmentedControl) {
        var sideText = "Right"
        if sender.selectedSegmentIndex == 0 {
            sideText = "Left"
        }
        measurement?.setValue(sideText, forKey: "side")
    }

    @IBAction func unwindWithSelectedJoint(segue: UIStoryboardSegue) {
        if let jointPickerViewController = segue.source as? JointPickerViewController,
            let selectedJoint = jointPickerViewController.selectedJoint {
            measurement?.setValue(selectedJoint, forKey: "joint")
        }
    }
    @IBAction func unwindWithSelectedDirection(segue: UIStoryboardSegue) {
        if let motionPickerViewController = segue.source as? MotionPickerViewController,
            let selectedMotion = motionPickerViewController.selectedMotion {
            measurement?.setValue(selectedMotion, forKey: "motion")
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
