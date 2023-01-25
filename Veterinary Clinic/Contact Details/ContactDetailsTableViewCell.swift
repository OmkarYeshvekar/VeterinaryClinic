//
//  ContactDetailsTableViewCell.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 14/01/23.
//

import UIKit

class ContactDetailsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var innerStackView: UIStackView!
    
    @IBOutlet weak var contactMethodButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    @IBOutlet weak var officeHoursButton: UIButton!

    var chatButtonClicked: () -> Void = {}
    var callButtonClicked: () -> Void = {}
    var contactMethodButtonClicked: () -> Void = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        setupButtons()
    }
    
    private func setupButtons() {
        contactMethodButton.layer.cornerRadius = 8
        contactMethodButton.clipsToBounds = true
        
        chatButton.layer.cornerRadius = 8
        chatButton.clipsToBounds = true
        
        callButton.layer.cornerRadius = 8
        callButton.clipsToBounds = true
        
        officeHoursButton.layer.borderColor = UIColor.lightGray.cgColor
        officeHoursButton.layer.borderWidth = 3.0
        officeHoursButton.isUserInteractionEnabled = false
    }
    
    func setArrangeContactButtons(data: ConfigScreenModel) {
        
        let chatEnabled = data.isChatEnabled ?? false
        let callEnabled = data.isCallEnabled ?? false
        
        if chatEnabled && callEnabled {
            self.contactMethodButton.isHidden = true
            
        } else if !chatEnabled && !callEnabled {
            self.contactMethodButton.isHidden = true
            self.innerView.isHidden = true
            
        } else {
            self.innerView.isHidden = true
            let contactWay = chatEnabled ? StringConstants.chatString : StringConstants.callString
            let contactButtonColor: UIColor = chatEnabled ? .systemBlue : .systemGreen
            self.contactMethodButton.setTitle(contactWay, for: .normal)
            self.contactMethodButton.backgroundColor = contactButtonColor
        }
    }
    
    
    @IBAction func contactMethodButtonClicked(_ sender: Any) {
        contactMethodButtonClicked()
    }
    
    @IBAction func chatButtonClicked(_ sender: Any) {
        chatButtonClicked()
    }
    
    @IBAction func callButtonClicked(_ sender: Any) {
        callButtonClicked()
    }
}
