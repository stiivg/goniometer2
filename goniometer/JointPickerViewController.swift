//
//  JointPickerViewController.swift
//  goniometer
//
//  Created by Steven Gallagher on 11/27/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit


class JointPickerViewController: UITableViewController {
    
    // MARK: - Properties
    var joints = [
        //Upper Body
        "Jaw",
        "Neck",
        "Back",
        "Shoulder",
        "Elbow",
        "Forearm",
        "Wrist",
        "Knuckle",
        "Finger",
        "Thumb",
        //Lower Body
        "Hip",
        "Knee",
        "Ankle",
        "Heel",
        "Toe"
    ]
    
    var selectedJoint: String? {
        didSet {
            if let selectedJoint = selectedJoint,
                let index = joints.index(of: selectedJoint) {
                selectedJointIndex = index
            }
        }
    }
    
    var selectedJointIndex: Int?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "SaveSelectedJoint",
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) else {
                return
        }
        
        let index = indexPath.row
        selectedJoint = joints[index]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return joints.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JointCell", for: indexPath)
        cell.textLabel?.text = joints[indexPath.row]
        
        if indexPath.row == selectedJointIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Other row is selected - need to deselect it
        if let index = selectedJointIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedJoint = joints[indexPath.row]
        
        // update the checkmark for the current row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
}

