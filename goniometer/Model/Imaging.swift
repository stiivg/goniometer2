//
//  Imaging.swift
//  goniometer
//
//  Created by Steven Gallagher on 12/7/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

class Imaging {

    var measurement: NSManagedObject?

    init() {
    
    }
    
    func setMeasurementObj(measurementObj: NSManagedObject) {
        measurement = measurementObj
    }
    
    func prepareImageForSaving(imageView:UIImageView) {
        
        // create NSData from UIImage
        guard let imageData = UIImageJPEGRepresentation(imageView.image!, 1) else {
            // handle failed conversion
            print("jpg error")
            return
        }
        
        //TODO capture the angle dots and lines in image
        // scale image to imageview size
        let thumbnail = imageView.image?.scale(toSize: imageView.frame.size)
        
        guard let thumbnailData  = UIImageJPEGRepresentation(thumbnail!, 0.7) else {
            // handle failed conversion
            print("jpg error")
            return
        }
        
        // send to save function
        self.saveImage(imageData: imageData as NSData, thumbnailData: thumbnailData as NSData)
        
    }
    
    func saveImage(imageData:NSData, thumbnailData:NSData) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext =  appDelegate.persistentContainer.viewContext
        
        let fullResEntity = measurement?.value(forKey: "fullRes") as? NSManagedObject
        var fullRes = NSManagedObject()
        
        if (fullResEntity == nil) {
            //Create a new fulleRes object
            let entity = NSEntityDescription.entity(forEntityName: "FullRes", in: managedContext)!
            fullRes = NSManagedObject(entity: entity, insertInto: managedContext)
            
            //set image data of fullres
            fullRes.setValue(imageData, forKey: "imageData")
            //set link to fullRes image
            measurement?.setValue(fullRes, forKey: "fullRes")
        } else {
            //set image data of existing fullres
            fullResEntity?.setValue(imageData, forKey: "imageData")
        }

        
        //set image data of thumbnail
        measurement?.setValue(thumbnailData, forKey: "thumbnail")
        
        // save the new objects
        do {
            try managedContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        // clear the managedContext
        managedContext.refreshAllObjects()
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
