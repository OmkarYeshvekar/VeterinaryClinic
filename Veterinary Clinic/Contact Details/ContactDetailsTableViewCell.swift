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
    
    var currentDate: Date? = nil
    
    var chatButtonClicked: (_ message: String) -> Void = {_ in}
    var callButtonClicked: (_ message: String) -> Void = {_ in}
    var contactMethodButtonClicked: (_ message: String) -> Void = {_ in}
    
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
        
        guard let officeHours = data.officeHours,
                let isChatHidden = data.isChatHidden,
                let isCallingHidden = data.isCallingHidden  else { return }
        
        
        self.officeHoursButton.setTitle("Office Hours: \(officeHours)", for: .normal)
        if isChatHidden && isCallingHidden {
            self.contactMethodButton.isHidden = true
            self.innerView.isHidden = true
        } else {
            
            let chatEnabled = !isChatHidden
            let callEnabled = !isCallingHidden
            
            if chatEnabled && callEnabled {
                self.contactMethodButton.isHidden = true
            } else {
                self.innerView.isHidden = true
                let contactWay = chatEnabled ? StringConstants.chatString : StringConstants.callString
                let contactButtonColor: UIColor = chatEnabled ? .systemBlue : .systemGreen
                self.contactMethodButton.setTitle(contactWay, for: .normal)
                self.contactMethodButton.backgroundColor = contactButtonColor
            }
        }
    }
    
    
    
    @IBAction func contactMethodButtonClicked(_ sender: Any) {
        let message = checkClinicTimings()
        contactMethodButtonClicked(message)
    }
    
    @IBAction func chatButtonClicked(_ sender: Any) {
        let message = checkClinicTimings()
        chatButtonClicked(message)
    }
    
    @IBAction func callButtonClicked(_ sender: Any) {
        let  message = checkClinicTimings()
        callButtonClicked(message)
    }
    
    private func checkClinicTimings() -> String {
        let saturday = StringConstants.saturday
        let sunday = StringConstants.sunday
        let now = self.currentDate ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let day = dateFormatter.string(from: now).capitalized.lowercased()
        
        if day == saturday || day == sunday {
            //NOTE: it seems to be a weekEnd. Out of office hours.
            return StringConstants.workHourEndMessage
            
        } else {
            //NOTE: it seems to be a weekday. check time.
            
            //NOTE: create dateFormatter with UTC time format
            let dateFormatter = DateFormatter()
            //NOTE: change to a readable time format and change to local time zone
            dateFormatter.dateFormat = "HH:mm"
            let timeStamp = dateFormatter.string(from: now)
            debugPrint("Time stamp: ", timeStamp)
            
            let openHours = now.dateAt(hours: 10, minutes: 00)
            let closeHours = now.dateAt(hours: 18, minutes: 00)
            
            if now >= openHours && now <= closeHours {
                return StringConstants.thankYouMessage
            } else {
                return StringConstants.workHourEndMessage
            }
        }
    }
}
