//
//  DirectionPickerViewController.swift
//  goniometer
//
//  Created by Steven Gallagher on 11/28/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit

class DirectionPickerViewController: UITableViewController {
    
        // MARK: - Properties
        var directions = [
            "Flexion",
            "Extension",
            "Abduction",
            "Supination",
            "Pronation"
        ]
        
        var selectedDirection: String? {
            didSet {
                if let selectedDirection = selectedDirection,
                    let index = directions.index(of: selectedDirection) {
                    selectedDirectionIndex = index
                }
            }
        }
        
        var selectedDirectionIndex: Int?
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            guard segue.identifier == "SaveSelectedDirection",
                let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) else {
                    return
            }
            
            let index = indexPath.row
            selectedDirection = directions[index]
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
            return directions.count
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DirectionCell", for: indexPath)
            cell.textLabel?.text = directions[indexPath.row]
            
            if indexPath.row == selectedDirectionIndex {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            // Other row is selected - need to deselect it
            if let index = selectedDirectionIndex {
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
                cell?.accessoryType = .none
            }
            
            selectedDirection = directions[indexPath.row]
            
            // update the checkmark for the current row
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
        }
}


