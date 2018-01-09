//
//  DirectionPickerViewController.swift
//  bodyflex
//
//  Created by Steven Gallagher on 11/28/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit

class MotionPickerViewController: UITableViewController {
    
        // MARK: - Properties
        var motions = [
            "Flexion",
            "Extension",
            "Abduction",
            "Supination",
            "Pronation"
        ]
        
        var selectedMotion: String? {
            didSet {
                if let selectedMotion = selectedMotion,
                    let index = motions.index(of: selectedMotion) {
                    selectedMotionIndex = index
                }
            }
        }
        
        var selectedMotionIndex: Int?
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            guard segue.identifier == "SaveSelectedDirection",
                let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) else {
                    return
            }
            
            let index = indexPath.row
            selectedMotion = motions[index]
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
            return motions.count
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MotionCell", for: indexPath)
            cell.textLabel?.text = motions[indexPath.row]
            
            if indexPath.row == selectedMotionIndex {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            // Other row is selected - need to deselect it
            if let index = selectedMotionIndex {
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
                cell?.accessoryType = .none
            }
            
            selectedMotion = motions[indexPath.row]
            
            // update the checkmark for the current row
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
        }
}


