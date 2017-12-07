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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var angleText: UILabel!
    
    var dotLayer = CAShapeLayer()
    var dotStartPosition = CGPoint(x: 100, y: 200)
    
    let beginDotLayer = CAShapeLayer()
    let middleDotLayer = CAShapeLayer()
    let endDotLayer = CAShapeLayer()
    
    let beginLineLayer = CAShapeLayer()
    let endLineLayer = CAShapeLayer()

    let textLayer = CATextLayer()

    var beginDotPosition = CGPoint(x: 100, y: 300)
    var middleDotPosition = CGPoint(x: 100, y: 200)
    var endDotPosition = CGPoint(x: 150, y: 200)
    var dotPositions = [CGPoint]()
    var movingDotIndex = 1
    
    var panStart = CGPoint(x: 0, y: 0)
    
    var measuredAngle = CGFloat()
    
    // moc
    var managedContext : NSManagedObjectContext?

    @IBAction func handleDotPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began {
            panStart = gestureRecognizer.location(in: self.view)
            let beginDistance = hypot(dotPositions[0].x - panStart.x, dotPositions[0].y - panStart.y)
            let middleDistance = hypot(dotPositions[1].x - panStart.x, dotPositions[1].y - panStart.y)
            let endDistance = hypot(dotPositions[2].x - panStart.x, dotPositions[2].y - panStart.y)
            
            //   Set movingDotIndex to the nearest dot to move
            let nearestDot = min(min(beginDistance, middleDistance), endDistance)
            switch nearestDot {
            case beginDistance:
                movingDotIndex = 0
            case middleDistance:
                movingDotIndex = 1
            case endDistance:
                movingDotIndex = 2
            default:
                movingDotIndex = 0
            }

            dotStartPosition = dotPositions[movingDotIndex]
        } else if gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.view)
            dotPositions[movingDotIndex] = CGPoint(x: dotStartPosition.x + translation.x, y: dotStartPosition.y + translation.y)
            
            drawDots()
            drawLines()
            drawAngle()
        }
    }
    

    var imagePicker = UIImagePickerController()

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
//        prepareImageForSaving(image: chosenImage)
        dismiss(animated:true, completion: nil)
    }
    
    //Save last edit to image
    func completeEdit() {
        prepareImageForSaving(image: imageView.image!)
        measurement?.setValue(measuredAngle, forKey: "angle")
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
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
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
        dotPositions = [beginDotPosition, middleDotPosition, endDotPosition]
        
        drawDots()
        drawLines()
        drawAngle()
        
        view.layer.addSublayer(beginLineLayer)
        view.layer.addSublayer(endLineLayer)

 
        view.layer.addSublayer(beginDotLayer)
        view.layer.addSublayer(middleDotLayer)
        view.layer.addSublayer(endDotLayer)
        view.isUserInteractionEnabled = true
  

        imagePicker.delegate = self

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

    func drawDots() {
        let beginOrigin = CGPoint(x: dotPositions[0].x - 6, y: dotPositions[0].y - 6)
        let beginDotPath = UIBezierPath(ovalIn: CGRect(origin: beginOrigin, size: CGSize(width: 12, height: 12)))
        
        beginDotLayer.path = beginDotPath.cgPath
        beginDotLayer.fillColor = UIColor.red.cgColor

        let middleOrigin = CGPoint(x: dotPositions[1].x - 6, y: dotPositions[1].y - 6)
        let middleDotPath = UIBezierPath(ovalIn: CGRect(origin: middleOrigin, size: CGSize(width: 12, height: 12)))

        middleDotLayer.path = middleDotPath.cgPath
        middleDotLayer.fillColor = UIColor.green.cgColor

        let endOrigin = CGPoint(x: dotPositions[2].x - 6, y: dotPositions[2].y - 6)
        let endDotPath = UIBezierPath(ovalIn: CGRect(origin: endOrigin, size: CGSize(width: 12, height: 12)))

        endDotLayer.path = endDotPath.cgPath
        endDotLayer.fillColor = UIColor.blue.cgColor

    }
    
    func drawLines() {
        let beginPath = UIBezierPath()
        beginPath.move(to: dotPositions[0])
        beginPath.addLine(to: dotPositions[1])
        
        beginLineLayer.path = beginPath.cgPath
        beginLineLayer.lineWidth = 2.0
        //        beginLineLayer.fillColor = nil
        //        beginLineLayer.opacity = 1.0
        beginLineLayer.strokeColor = UIColor.cyan.cgColor
        
        let endPath = UIBezierPath()
        endPath.move(to: dotPositions[1])
        endPath.addLine(to: dotPositions[2])
        
        endLineLayer.path = endPath.cgPath
        endLineLayer.lineWidth = 2.0
        //        endLineLayer.fillColor = nil
        //        endLineLayer.opacity = 1.0
        endLineLayer.strokeColor = UIColor.cyan.cgColor
        
    }
    
    func drawAngle() {
        calcAngle()
        angleText.text = String(format: "%.1f", measuredAngle) + "\u{00B0}"
    }
    
    func calcAngle() {
        let distance01 = hypot(dotPositions[0].x - dotPositions[1].x, dotPositions[0].y - dotPositions[1].y)
        let distance12 = hypot(dotPositions[1].x - dotPositions[2].x, dotPositions[1].y - dotPositions[2].y)
        let distance02 = hypot(dotPositions[0].x - dotPositions[2].x, dotPositions[0].y - dotPositions[2].y)

        let cosAngleNumerator = pow(distance01, 2) +  pow(distance12, 2)  - pow(distance02, 2)
        let cosAngleDenominator = 2 * distance01 * distance12
        let cosAngle = cosAngleNumerator / cosAngleDenominator
        let angleRadians = acos(cosAngle)
        measuredAngle = 180 - (angleRadians * CGFloat(180 / CGFloat.pi));
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
