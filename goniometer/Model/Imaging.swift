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

        // scale image to a good thumbnail size
        let thumnbnailSize = CGSize(width: 800, height: 600)
        let thumbnail = createThumbnail(imageView: imageView, toSize: thumnbnailSize)
        
        guard let thumbnailData  = UIImageJPEGRepresentation(thumbnail, 0.7) else {
            // handle failed conversion
            print("jpg error")
            return
        }
        
        // send to save function
        self.saveImage(imageData: imageData as NSData, thumbnailData: thumbnailData as NSData)
    }
    
    fileprivate func saveImage(imageData:NSData, thumbnailData:NSData) {
        
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
    }
    
    fileprivate func createThumbnail(imageView:UIImageView, toSize newSize:CGSize) -> UIImage {
        let thumbImage = imageView.image!
        // make sure the new size has the correct aspect ratio
        //it is aspectFill so can be larger in one direction than the standard
        let aspectFill = thumbImage.size.resizeFill(toSize: newSize)
        UIGraphicsBeginImageContextWithOptions(aspectFill, true, 1.0);
        thumbImage.draw(in: CGRect(x: 0, y: 0, width: aspectFill.width, height: aspectFill.height))

        let imageRect = calculateRectOfImageInImageView(imageView: imageView)
        
        let xScale = aspectFill.width / imageRect.width
        let yScale = aspectFill.height / imageRect.height

        //scale the context for the sublayer rendering
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.scaleBy(x: xScale, y: yScale)
        ctx?.translateBy(x: -imageRect.origin.x, y: -imageRect.origin.y)
//        thumbImage.draw(at: CGPoint(x: 0, y: 0))
        imageView.layer.sublayers![0].render(in: ctx!)
        imageView.layer.sublayers![1].render(in: ctx!)
        imageView.layer.sublayers![2].render(in: ctx!)
        imageView.layer.sublayers![3].render(in: ctx!)
        imageView.layer.sublayers![4].render(in: ctx!)
        imageView.layer.sublayers![5].render(in: ctx!)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }

    // Assumes the image is aspectFit in imageview
    //centered with either width or height the same
    fileprivate func calculateRectOfImageInImageView(imageView: UIImageView) -> CGRect {
        let imageViewSize = imageView.bounds.size
        let imgSize = imageView.image?.size
        
        guard let imageSize = imgSize, imgSize != nil else {
            return CGRect.zero
        }
        
        let scaleWidth = imageViewSize.width / imageSize.width
        let scaleHeight = imageViewSize.height / imageSize.height
        let aspect = fmin(scaleWidth, scaleHeight)
        
        var imageRect = CGRect(x: 0, y: 0, width: imageSize.width * aspect, height: imageSize.height * aspect)
        // Center image
        imageRect.origin.x = (imageViewSize.width - imageRect.size.width) / 2
        imageRect.origin.y = (imageViewSize.height - imageRect.size.height) / 2
        
        // Add imageView offset
        imageRect.origin.x += imageView.frame.origin.x
        imageRect.origin.y += imageView.frame.origin.y
        
        return imageRect
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
