//
//  SelectJointViewController.swift
//  bodyflex
//
//  Created by Steven Gallagher on 11/22/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

class SelectJointViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var jointDescriptionLabel: UILabel!
    @IBOutlet weak var jointImage: UIImageView!
    @IBOutlet weak var jointMotionTable: UITableView!
    
    
    // MARK: - Properties
    var joint: Joint? //Joint struct with all possible motions
    var motion: MotionStruct? //Selected motion
    
    var side: String = "Right"
    
    private var angleToolDrawing = AngleToolDrawing()
    private var dotPositions = [CGPoint(), CGPoint(), CGPoint()]
    
    

    @IBAction func jointTextEditEnd(_ sender: UITextField) {
        joint?.name.common = sender.text!
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "JointCell")!
            //if custom joint enable editing
            if joint?.name.medical == "Custom Measurement" {
                (cell as! JointCell).jointText.isEnabled = true
                (cell as! JointCell).jointText.borderStyle = .roundedRect
                (cell as! JointCell).jointText.text = joint?.name.common //Restore custom name
                (cell as! JointCell).jointText.delegate = self
            } else {
                (cell as! JointCell).jointText.isEnabled = false
                (cell as! JointCell).jointText.borderStyle = .none
                (cell as! JointCell).jointText.text = (joint?.name.common)!
            }
            (cell as! JointCell).jointLabelMedical.text = joint?.name.medical

        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "MotionCell")!
            (cell as! MotionCell).motionLabel.text = (motion?.name.common)!
            (cell as! MotionCell).motionLabelMedical.text = (motion?.name.medical)

        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "SideCell")!
            var index = 0  //assume Left
            if side == "Right" {
                index = 1
            }
            (cell as! SideCell).sideControl.selectedSegmentIndex = index
        default:
            cell = UITableViewCell()
        }
        
        return cell
    }
    
    //Dismiss keyboard on Enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
    //Save last edit to custom joint
    func completeEdit() {
        let cell = jointMotionTable.cellForRow(at: IndexPath(row: 0, section: 0))
        (cell as! JointCell).jointText.endEditing(true)
    }

   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "PickJoint",
            let jointPickerViewController = segue.destination as? JointPickerViewController {
            jointPickerViewController.selectedJoint = self.joint
        }
        if segue.identifier == "PickMotion",
            let motionPickerViewController = segue.destination as? MotionPickerViewController {
            motionPickerViewController.jointMotions = self.joint?.motions
            motionPickerViewController.selectedMotion = self.motion
        }
    }
    
   fileprivate func updateJointImage() {
        let imageName = (joint?.name.common)! + " " + (motion?.name.common)!
        var img = loadImage(fileName: imageName)
        if side == "Left" && img != nil {
            //Flip image
            img = UIImage(cgImage: (img?.cgImage!)!, scale: 1.0, orientation: UIImageOrientation.upMirrored)
        }
        jointImage.image = img
    
        jointDescriptionLabel.text = motion?.description
        setAngleToolDrawing()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        jointMotionTable.reloadData()
        
        updateJointImage()

    }
    
    //Restore dot positions from core data or use default
    fileprivate func restoreLocation() {
        //convert pixel positions to image view locations
        let imageTransform = angleToolDrawing.calculateImageTransform(imageView: jointImage!)
        dotPositions[0] = angleToolDrawing.convertPixelToLocation(position: (motion?.defaultDotPoints[0])!, origin: imageTransform.rect.origin, scale: imageTransform.scale)
            
        dotPositions[1] = angleToolDrawing.convertPixelToLocation(position: (motion?.defaultDotPoints[1])!, origin: imageTransform.rect.origin, scale: imageTransform.scale)
            
        dotPositions[2] = angleToolDrawing.convertPixelToLocation(position: (motion?.defaultDotPoints[2])!, origin: imageTransform.rect.origin, scale: imageTransform.scale)
   
        //Demo image and dot locations assumes right side
        if side == "Left" {
            dotPositions[0].x = jointImage.bounds.width - dotPositions[0].x
            dotPositions[1].x = jointImage.bounds.width - dotPositions[1].x
            dotPositions[2].x = jointImage.bounds.width - dotPositions[2].x
        }

    }
    
    fileprivate func  setAngleToolDrawing() {
        var rotationCW = motion?.rotation == "CW"
        // Defaults to the right side
        if side == "Left" {
            rotationCW = !rotationCW
        }
        
        angleToolDrawing.rotationCW = rotationCW
        angleToolDrawing.setQuadrant(rotationCW: rotationCW, insideOutside: motion!.insideOutside)
    
        restoreLocation()
        if jointImage.image != nil {
            angleToolDrawing.setMotion(motion: motion!)
            angleToolDrawing.setSide(side: side)
            angleToolDrawing.drawTool(dotPositions: dotPositions)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        angleToolDrawing.animation = false
        angleToolDrawing.addLabels = true
        angleToolDrawing.addAngle = false
        angleToolDrawing.setImageView(imageView: jointImage)
        
        
        
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
    
    
}

private func loadImage(fileName: String) -> UIImage? {
//    let imageURL = Bundle.main.url(forResource: fileName, withExtension: "png")
    guard let imageURL = Bundle.main.url(forResource: fileName, withExtension: "png") else { return nil }
    let newImage = UIImage(contentsOfFile: (imageURL.path))!
    return newImage
}

// MARK: - IBActions
extension SelectJointViewController {


    @IBAction func sideControl(_ sender: UISegmentedControl) {
        var sideText = "Right"
        if sender.selectedSegmentIndex == 0 {
            sideText = "Left"
        }
        self.side = sideText
        
        updateJointImage()
    }

    @IBAction func unwindWithSelectedJoint(segue: UIStoryboardSegue) {
        if let jointPickerViewController = segue.source as? JointPickerViewController,
            let selectedJoint = jointPickerViewController.selectedJoint {
            self.joint = selectedJoint
            self.motion = selectedJoint.motions[0] //Default to the first motion of new joint selected
        }
    }
    @IBAction func unwindWithSelectedMotion(segue: UIStoryboardSegue) {
        if let motionPickerViewController = segue.source as? MotionPickerViewController,
            let selectedMotion = motionPickerViewController.selectedMotion {
            self.motion = selectedMotion
        }
    }
}

