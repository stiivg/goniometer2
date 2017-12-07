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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var angleText: UILabel!
    
    // moc
    var managedContext : NSManagedObjectContext?

    @IBAction func handleDotPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        angleTool.doHandleDotPan(gestureRecognizer: gestureRecognizer, view: self.view)
    }
    

    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        angleTool.addToolLayers(imageView: imageView)
        angleTool.angleLabel = angleText
        angleTool.drawAngle()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        self.managedContext =  appDelegate.persistentContainer.viewContext
        
        //display the full resolution image
        let fullResEntity = measurement?.value(forKey: "fullRes") as? NSManagedObject
        if let fullImageData = fullResEntity?.value(forKey: "imageData") {
            let fullImage = UIImage(data: fullImageData as! Data)
            imageView.image = fullImage
        }
        
        
        imagePicker.delegate = self
        
    }

    @IBAction func photoFromLibrary(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
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
        prepareImageForSaving(image: imageView.image!)
        measurement?.setValue(angleTool.measuredAngle, forKey: "angle")
    }
    
    func prepareImageForSaving(image:UIImage) {
        
        // use date as unique id
        let date : Double = NSDate().timeIntervalSince1970
        
        // dispatch with gcd.
        
        // create NSData from UIImage
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {
            // handle failed conversion
            print("jpg error")
            return
        }
        
        //TODO capture the angle dots and lines in image
        // scale image, I chose the size of the VC because it is easy
        let thumbnail = image.scale(toSize: self.view.frame.size)
        
        guard let thumbnailData  = UIImageJPEGRepresentation(thumbnail, 0.7) else {
            // handle failed conversion
            print("jpg error")
            return
        }
        
        // send to save function
        self.saveImage(imageData: imageData as NSData, thumbnailData: thumbnailData as NSData, date: date)
            
    }
    
    func saveImage(imageData:NSData, thumbnailData:NSData, date: Double) {
        
        // create new objects in moc
        guard let moc = self.managedContext else {
            return
        }
        

//        guard let fullRes = NSEntityDescription.insertNewObject(forEntityName: "FullRes", into: moc) as? FullRes else {
//            // handle failed new object in moc
//            print("moc error")
//            return
//        }
        
        //Create a new fulleRes object
        let entity = NSEntityDescription.entity(forEntityName: "FullRes", in: moc)!
        let fullRes = NSManagedObject(entity: entity, insertInto: moc)

        //set image data of fullres
        fullRes.setValue(imageData, forKey: "imageData")
        
        
        //set image data of thumbnail
        measurement?.setValue(thumbnailData, forKey: "thumbnail")
        //set link to fullRes image
        measurement?.setValue(fullRes, forKey: "fullRes")
        
        // save the new objects
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        // clear the moc
        moc.refreshAllObjects()
    }
 
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    //Limit zoom out to Aspect Fit
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
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

extension CGSize {
    
    func resizeFill(toSize: CGSize) -> CGSize {
        
        let scale : CGFloat = (self.height / self.width) < (toSize.height / toSize.width) ? (self.height / toSize.height) : (self.width / toSize.width)
        return CGSize(width: (self.width / scale), height: (self.height / scale))
        
    }
}

extension UIImage {
    
    func scale(toSize newSize:CGSize) -> UIImage {
        
        // make sure the new size has the correct aspect ratio
        let aspectFill = self.size.resizeFill(toSize: newSize)
        
        UIGraphicsBeginImageContextWithOptions(aspectFill, true, 1.0);
        self.draw(in: CGRect(x: 0, y: 0, width: aspectFill.width, height: aspectFill.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
    }
    
}
