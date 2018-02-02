

//
//  MeasureAngleViewController
//  bodyflex
//
//  Created by Steven Gallagher on 11/15/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData
import Photos

class MeasureAngleViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate {

//    var joints = BodyJoints()
    
    //MARK: Properties
    private var measurement = MeasurementsAPI.shared.newMeasurement()
    var angleTool = AngleTool()
    
    var imaging = Imaging()
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    @IBOutlet weak var scrollView: GestureScrollView!
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var medicalJointLabel: UILabel!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var jointLabel: UITextField!
    @IBOutlet weak var dateLabel: UITextField!
    
    
    @IBAction func handleDotPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        angleTool.doHandleDotPan(gestureRecognizer: gestureRecognizer, view: self.imageView)
    }
    
    var firstViewAppearance = true
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
    //Delete the current measurement before replacing
    func setMeasurement(newMeasurement: Measurement) {
        MeasurementsAPI.shared.deleteMeasurement(measurement: measurement)
        self.measurement = newMeasurement
    }

     fileprivate func updateValues() {
        let jointMotion = measurement.jointMotion
        nameLabel.text = measurement.name
        let joint = jointMotion?.nameCommon
        let side = jointMotion?.side
        let motion = jointMotion?.motionCommon
        
        if jointMotion?.nameMedical == "Custom Measurement" {
            jointLabel.text = joint!
        } else {
            jointLabel.text = side! + " " +  joint! + " " + motion!
        }
        
        var mJoint = jointMotion?.nameMedical
        var mMotion = jointMotion?.motionMedical
        //if no medical term use common term
        if mJoint == "" {
            mJoint = joint
        }
        if mMotion == "" {
            mMotion = motion
        }
        if jointMotion?.nameMedical == "Custom Measurement" {
            medicalJointLabel.text = mJoint!
        } else {
            medicalJointLabel.text = side! + " " +  mJoint! + " " + mMotion!
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let dateObj = measurement.photoDate
        dateLabel.text = dateFormatter.string(from: dateObj!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateValues()
    }
    
    //Scrollview bounds are not set in viewDidLoad need to wait for layout complete
    //May be called multiple times if layout changed such as screen rotate
    override func viewDidLayoutSubviews() {
        //Only call this set up once, if called after image zoomed it goes very wrong
        if firstViewAppearance {
            firstViewAppearance = false
            
            let imageWidth = scrollView.bounds.width
            let imageHeight = scrollView.bounds.height
            imageWidthConstraint.constant = imageWidth
            imageHeightConstraint.constant = imageHeight
            
            //make the image view fill the scroll view 414 628
            let zeroOriginScrollBounds = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
            
            imageView.bounds = zeroOriginScrollBounds
            imageView.frame = zeroOriginScrollBounds
            scrollView.minimumZoomScale = 1.0
            

            angleTool.setMeasurementObj(measurementObj: measurement)
            
            //Used to detect touches near the measuring dots
            scrollView.setAngleTool(theAngleTool: angleTool)
            
            //display the full resolution image
            let fullResEntity = measurement.fullRes
            if let fullImageData = fullResEntity?.imageData {
                let fullImage = UIImage(data: fullImageData)
                imageView.image = fullImage
            }
            
            //call after image has been loaded
            angleTool.setImageView(imageView: imageView)
            
            imagePicker.delegate = self
            
            nameLabel.delegate = self
        }
    }
    
    @IBAction func shootPhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera;
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
  
    @IBAction func nameEditEnd(_ sender: UITextField) {
        measurement.name = sender.text
    }
    
    @IBAction func photoFromLibrary(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func MeasurementTouchDown(_ sender: Any) {
        //Segue modally to joint editor
        performSegue(withIdentifier: "measurementToEditor", sender: nil)
        
    }
    
    @IBAction func cancelSelectJointMotion(_ segue: UIStoryboardSegue) {
    }
    
    // Return from editing joint and motion
    @IBAction func saveSelectJointMotion(_ segue: UIStoryboardSegue) {
        //make JointMotion managed object and add to measurement and update values
        let selectJointViewController = segue.source as? SelectJointViewController
        
        //End edit of custom joint name if in progress
        selectJointViewController?.completeEdit()
        
        let joint = selectJointViewController?.joint
        let motion = selectJointViewController?.motion
        let side = selectJointViewController?.side
        let jointMotion = MeasurementsAPI.shared.bodyJoints.newJointMotion(joint: joint!, motion: motion!, side: side!)

        //Delete the current jointMotion managed Object if it exists
        MeasurementsAPI.shared.deleteJointMotion(measurement: measurement)

        self.measurement.jointMotion = jointMotion
        
        //Redraw tool in case angle geometry changed
        angleTool.setJointMotion(jointMotion: measurement.jointMotion!)
    }
    
    //Dismiss keyboard on Enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        if info[UIImagePickerControllerEditedImage] != nil {
            chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        }
        imageView.contentMode = .scaleAspectFit
        imageView.image = chosenImage
        dismiss(animated:true, completion: nil)

        MeasurementsAPI.shared.deleteFullRes(measurement: measurement)

        //clear the link to fullRes image
        measurement.fullRes = nil
        
        //Assume current date and time
        measurement.photoDate = Date()
        
        //Works for library but no PHAsset for photo
        if let asset = info[UIImagePickerControllerPHAsset] as? PHAsset {
            let photoDate = asset.creationDate
            measurement.photoDate = photoDate
        }
        
    }
    
    //Save last edit to image
    func completeEdit() {
        imaging.prepareImageForSaving(imageView: imageView, measurement: measurement)
        measurement.angle = Float(angleTool.measuredAngle())
        angleTool.saveLocation()
        nameLabel.endEditing(true)
    }
    
    func setCreatedDate() {
        measurement.createdDate = Date()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "measurementToEditor" {
            let nav = segue.destination as! UINavigationController
            let selectJointViewController = nav.topViewController as? SelectJointViewController
            
            //Create a Joint structure and motion structure from the jointMotion managed object
            let jointMotion = measurement.jointMotion
            let joint = MeasurementsAPI.shared.bodyJoints.jointFromJointMotion(jointMotion: jointMotion!)
            let motion = MeasurementsAPI.shared.bodyJoints.motionFromJointMotion(jointMotion: jointMotion!)
            selectJointViewController?.joint = joint
            selectJointViewController?.motion = motion
            selectJointViewController?.side = (jointMotion?.side)!
            
            completeEdit()
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


