//
//  SingleMeasurementViewController.swift
//  goniometer
//
//  Created by Steven Gallagher on 12/4/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

class SingleMeasurementViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var angleImageView: UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var jointLabel: UITextField!
    @IBOutlet weak var angleLabel: UITextField!
    @IBOutlet weak var dateLabel: UITextField!
    
    // MARK: - Properties
    var measurement: NSManagedObject?
    
    func updateValues() {
        guard let measurement = measurement else { return }

        let name = measurement.value(forKeyPath: "name") as? String
        nameLabel.text = name
        let joint = measurement.value(forKeyPath: "joint") as? String
        let side = measurement.value(forKeyPath: "side") as? String
        let motion = measurement.value(forKeyPath: "motion") as? String
        jointLabel.text = side! + " " +  joint! + " " + motion!
        angleLabel.text = String(format: "%.1f", (measurement.value(forKeyPath: "angle") as? Float)!) + "\u{00B0}"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let dateObj = measurement.value(forKeyPath: "date") as? Date
        dateLabel.text = dateFormatter.string(from: dateObj!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateValues()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        //Called on return to list not on entry
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
