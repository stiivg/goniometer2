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
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var jointLabel: UITextField!
    @IBOutlet weak var dateLabel: UITextField!
    
    
    @IBAction func handleDotPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        angleTool.doHandleDotPan(gestureRecognizer: gestureRecognizer, view: self.imageView)
    }
    
    var firstViewAppearance = true
    var imagePicker = UIImagePickerController()
    
    //Delete the current measurement before replacing
    func setMeasurement(newMeasurement: Measurement) {
        MeasurementsAPI.shared.deleteMeasurement(measurement: measurement)
        self.measurement = newMeasurement
    }

    func updateValues() {
        let jointMotion = measurement.jointMotion
        nameLabel.text = measurement.name
        let joint = jointMotion?.nameCommon
        let side = jointMotion?.side
        let motion = jointMotion?.motionCommon
        jointLabel.text = side! + " " +  joint! + " " + motion!
               
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let dateObj = measurement.date
        dateLabel.text = dateFormatter.string(from: dateObj!)
    }
    
    //Scrollview bounds are not set in viewDidLoad need to wait for layout complete
    //May be called multiple times if layout changed such as screen rotate
    override func viewWillAppear(_ animated: Bool) {
        updateValues()
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
            
            angleTool.setMeasurementObj(measurementObj: measurement)
            
            //Used to detect touches near the measuring dots
            scrollView.setAngleTool(theAngleTool: angleTool)
            
            //display the full resolution image
            let fullResEntity = measurement.fullRes
            if let fullImageData = fullResEntity?.imageData {
                let fullImage = UIImage(data: fullImageData)
                imageView.image = fullImage
            }
            
            updateMinZoomScaleForSize(scrollView.bounds.size)
            
            //call after image has been loaded
            angleTool.setImageView(imageView: imageView)
            
            imagePicker.delegate = self
            
            nameLabel.delegate = self
        }
    }
    
   
//    func imageDetails(imageview: UIImageView) {
//        print(String(describing: imageView))
//        let mode = imageView.contentMode
//        let screenScale = UIScreen.main.scale
//        let width = imageView.frame.width
//        let height = imageView.frame.height
//        let widthInPixels = imageView.frame.width * UIScreen.main.scale
//        let heightInPixels = imageView.frame.height * UIScreen.main.scale
//
//        let image = imageview.image
//        let imageScale = (image?.scale)!
//        let imsgeWidthInPixels = (image?.size.width)! * (image?.scale)!
//        let imageHeightInPixels = (image?.size.height)! * (image?.scale)!
//        let imsgeWidth = (image?.size.width)!
//        let imageHeight = (image?.size.height)!
//
//    }
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
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum;
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
        
        let joint = selectJointViewController?.joint
        let motion = selectJointViewController?.motion
        let side = selectJointViewController?.side
        let jointMotion = MeasurementsAPI.shared.bodyJoints.newJointMotion(joint: joint!, motion: motion!, side: side!)

        //Delete the current jointMotion managed Object if it exists
        MeasurementsAPI.shared.deleteJointMotion(measurement: measurement)

        self.measurement.jointMotion = jointMotion
    }
    
    //Dismiss keyboard on Enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = chosenImage
        dismiss(animated:true, completion: nil)

        MeasurementsAPI.shared.deleteFullRes(measurement: measurement)

        //clear the link to fullRes image
        measurement.fullRes = nil
        
        
        if let assertURL = info[UIImagePickerControllerReferenceURL] as? NSURL {
            let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [assertURL as URL], options: nil)
            if let asset = fetchResult.firstObject { //PHUnauthorizedFetchResult in simulator
                let photoDate = asset.creationDate
                measurement.date = photoDate
            }
        }
        
    }
    
    //Save last edit to image
    func completeEdit() {
        imaging.prepareImageForSaving(imageView: imageView, measurement: measurement)
        measurement.angle = Float(angleTool.measuredAngle)
        angleTool.saveLocation()
        nameLabel.endEditing(true)
    }
    

    //Limit zoom out to Aspect Fit
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        //Default to the full image in view
        scrollView.zoomScale = minScale
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

