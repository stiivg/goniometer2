//
//  JointPickerViewController.swift
//  bodyflex
//
//  Created by Steven Gallagher on 11/27/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit


class JointPickerViewController: UITableViewController {
    let allJoints = MeasurementsAPI.shared.bodyJoints.joints
    
    
    // MARK: - Properties
    var selectedJointIndex: Int?

    
    var selectedJoint: Joint? {
        didSet {
            if let selectedJoint = selectedJoint {
                var index = allJoints.index(where: { $0.name.common == selectedJoint.name.common })
                //If name not found assume custom name
                if index == nil {
                    index = 0 //Index of custom entry
                }
                selectedJointIndex = index
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "SaveSelectedJoint",
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) else {
                return
        }
        
        let index = indexPath.row
        selectedJoint = allJoints[index]
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
        return allJoints.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JointCell", for: indexPath)
        cell.textLabel?.text = allJoints[indexPath.row].name.common
        
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
        
        selectedJoint = allJoints[indexPath.row]
        
        // update the checkmark for the current row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
}

