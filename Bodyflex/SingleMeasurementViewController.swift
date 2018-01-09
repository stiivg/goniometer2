//
//  SingleMeasurementViewController.swift
//  bodyflex
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
    @IBOutlet weak var imageView: UIImageView!
    
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
        
        //display the image
        if let imageData = measurement.value(forKey: "thumbnail") {
            let testImage = UIImage(data: imageData as! Data)
            imageView.image = testImage
        }
        
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
    // MARK: - Navigation
    //Editing this measurement has been cancelled - rollback the changes
    @IBAction func cancelMeasurementEdit(_ segue: UIStoryboardSegue) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =  appDelegate.persistentContainer.viewContext
        managedContext.rollback() // Undo any edits
    }
    
    //Editing this measurement has finished - save the changes
    @IBAction func saveMeasurementEdit(_ segue: UIStoryboardSegue) {
        //Notify the edit view to complete all edits
        let addMeasurementViewController = segue.source as? AddMeasurementViewController
        addMeasurementViewController?.completeEdit()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext =  appDelegate.persistentContainer.viewContext

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SingleToEditMeasurement" {
            let nav = segue.destination as! UINavigationController
            let addMeasurementViewController = nav.topViewController as? AddMeasurementViewController
        
            // Pass the selected object to the new view controller.
            addMeasurementViewController?.measurement = measurement
        }
    }

}
