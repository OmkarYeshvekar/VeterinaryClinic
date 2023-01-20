//
//  PetInfoTableViewCell.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 15/01/23.
//

import UIKit

class PetInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
