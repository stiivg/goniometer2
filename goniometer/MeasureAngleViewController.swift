//
//  MeasureAngleViewController
//  goniometer
//
//  Created by Steven Gallagher on 11/15/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

class MeasureAngleViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate {

    //MARK: Properties
    var measurement: NSManagedObject?
    var angleTool = AngleTool()
    
    var imaging = Imaging()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    @IBOutlet weak var scrollView: GestureScrollView!
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBAction func handleDotPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        angleTool.doHandleDotPan(gestureRecognizer: gestureRecognizer, view: self.imageView)
    }
    
    
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateMinZoomScaleForSize(view.bounds.size)

        angleTool.setMeasurementObj(measurementObj: measurement!)
        // Do any additional setup after loading the view, typically from a nib.
        
        //Enable touches near the measuring dota
        scrollView.setAngleTool(theAngleTool: angleTool)
        
        //display the full resolution image
        let fullResEntity = measurement?.value(forKey: "fullRes") as? NSManagedObject
        if let fullImageData = fullResEntity?.value(forKey: "imageData") {
            let fullImage = UIImage(data: fullImageData as! Data)
            imageView.image = fullImage
        }

        //call after image has been loaded
        angleTool.setImageView(imageView: imageView)

        imagePicker.delegate = self
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

    @IBAction func photoFromLibrary(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    //Save last edit to image
    func completeEdit() {
        imaging.prepareImageForSaving(imageView: imageView)
        measurement?.setValue(angleTool.measuredAngle, forKey: "angle")
        angleTool.saveLocation()
    }
    
   
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        updateMinZoomScaleForSize(view.bounds.size)
//    }
    
    //Limit zoom out to Aspect Fit
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        //Default to the full image in view
        scrollView.zoomScale = minScale
    }

    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


