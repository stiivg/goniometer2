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
    var measurement: NSManagedObject? {
        didSet {
            guard let measurement = measurement else { return }
            
            nameLabel.text = measurement.value(forKeyPath: "name") as? String
            
            let joint = measurement.value(forKeyPath: "joint") as? String
            let side = measurement.value(forKeyPath: "side") as? String
            let motion = measurement.value(forKeyPath: "motion") as? String
            jointLabel.text = side! + " " +  joint! + " " + motion!
            angleLabel.text = String(format: "%.1f", (measurement.value(forKeyPath: "angle") as? Float)!) + "\u{00B0}"
            
            //display the image
            if let imageData = measurement.value(forKey: "thumbnail") {
                let testImage = UIImage(data: imageData as! Data)
                angleImageView.image = testImage
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateObj = measurement.value(forKeyPath: "date") as? Date
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
