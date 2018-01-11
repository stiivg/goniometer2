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
            
            let joint = measurement?.joint
            let side = measurement?.side
            let motion = measurement?.motion
            jointLabel.text = side! + " " +  joint! + " " + motion!
            angleLabel.text = String(format: "%.1f", (measurement?.angle)!) + "\u{00B0}"
            
            //display the image
            if let imageData = measurement?.thumbnail {
                let testImage = UIImage(data: imageData)
                angleImageView.image = testImage
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateObj = measurement?.date
            dateLabel.text = dateFormatter.string(from: dateObj!)
        }
    }

}
