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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jointLabel: UILabel!
    @IBOutlet weak var angleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var medicalJointLabel: UILabel!
    @IBOutlet weak var debugLabel: UILabel!
    
    // MARK: - Properties
    var measurement: Measurement? {
        didSet {
            nameLabel.text = measurement?.name
            //DEBUG: show tool position
            debugLabel.text = positionString()
            
            let joint = measurement?.jointMotion?.nameCommon
            let side = measurement?.jointMotion?.side
            let motion = measurement?.jointMotion?.motionCommon
            if measurement?.jointMotion?.nameMedical == "Custom Measurement" {
                jointLabel.text = joint!
            } else {
                jointLabel.text = side! + " " +  joint! + " " + motion!
            }

            var mJoint = measurement?.jointMotion?.nameMedical
            var mMotion = measurement?.jointMotion?.motionMedical
            //if no medical term use common term
            if mJoint == "" {
                mJoint = joint
            }
            if mMotion == "" {
                mMotion = motion
            }
            if measurement?.jointMotion?.nameMedical == "Custom Measurement" {
                medicalJointLabel.text = mJoint!
            } else {
                medicalJointLabel.text = side! + " " +  mJoint! + " " + mMotion!
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
