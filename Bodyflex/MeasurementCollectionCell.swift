//
//  MeasurementCollectionCell.swift
//  bodyflex
//
//  Created by Steven Gallagher on 1/4/18.
//  Copyright © 2018 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

class MeasurementCollectionCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var angleImageView: UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var jointLabel: UITextField!
    @IBOutlet weak var angleLabel: UITextField!
    @IBOutlet weak var dateLabel: UITextField!
    
    // MARK: - Properties
    var measurement: Measurement? {
        didSet {
            nameLabel.text = measurement?.name
            //DEBUG: show tool position
            nameLabel.text = positionString()
            
            let joint = measurement?.jointMotion?.nameCommon
            let side = measurement?.jointMotion?.side
            let motion = measurement?.jointMotion?.motionCommon
            if measurement?.jointMotion?.nameMedical == "Custom Measurement" {
                jointLabel.text = joint!
            } else {
                jointLabel.text = side! + " " +  joint! + " " + motion!
            }

            angleLabel.text = String(format: "%.1f", (measurement?.angle)!) + "\u{00B0}"
            
            //display the image
            if let imageData = measurement?.thumbnail {
                let testImage = UIImage(data: imageData)
                angleImageView.image = testImage
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateObj = measurement?.photoDate
            dateLabel.text = dateFormatter.string(from: dateObj!)
        }
    }

    //for debug display of tool location
    fileprivate func positionString() -> String {
        var positionString = ""
        let theMeasurement = measurement!
        let stationaryPosition = String(format: "%.0f", theMeasurement.beginX) + ", " + String(format: "%.0f", theMeasurement.beginY)
        let axisPosition = String(format: "%.0f", theMeasurement.middleX) + ", " + String(format: "%.0f", theMeasurement.middleY)
        let movingPosition = String(format: "%.0f", theMeasurement.endX) + ", " + String(format: "%.0f", theMeasurement.endY)
        
        positionString = "(" + stationaryPosition + "), " + "(" + axisPosition + "), " + "(" + movingPosition + ")"
        return positionString
    }

}
