//
//  MeasurementCell.swift
//  bodyflex
//
//  Created by Steven Gallagher on 11/22/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit
import CoreData

class MeasurementCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var angleImageView: UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var jointLabel: UITextField!
    @IBOutlet weak var angleLabel: UITextField!
    @IBOutlet weak var dateLabel: UITextField!
    
    // MARK: - Properties
    var measurement: Measurement? {
        didSet {
            guard let measurement = measurement else { return }
            
            nameLabel.text = measurement.name
            
            let joint = measurement.jointMotion?.nameCommon
            let side = measurement.jointMotion?.side
            let motion = measurement.jointMotion?.motionCommon
            jointLabel.text = side! + " " +  joint! + " " + motion!
            angleLabel.text = String(format: "%.1f", (measurement.angle)) + "\u{00B0}"

            //display the image
            if let imageData = measurement.thumbnail {
                let testImage = UIImage(data: imageData)
                angleImageView.image = testImage
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateObj = measurement.date
            dateLabel.text = dateFormatter.string(from: dateObj!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
