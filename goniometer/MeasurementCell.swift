//
//  MeasurementCell.swift
//  goniometer
//
//  Created by Steven Gallagher on 11/22/17.
//  Copyright © 2017 Steven Gallagher. All rights reserved.
//

import UIKit

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
            jointLabel.text = measurement.side! + " " +  measurement.joint! + " " + measurement.direction!
            angleLabel.text = String(format: "%.1f", measurement.angle) + "\u{00B0}"
            dateLabel.text = measurement.date
//            angleImageView.image = image(forRating: player.rating)
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
