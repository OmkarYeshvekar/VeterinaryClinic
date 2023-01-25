//
//  StringConstants.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 20/01/23.
//

import Foundation

struct StringConstants {
    
    //MARK: API Error's
    static let noInternetError = "Please check your internet connection or try again later"
    static let invalidJsonError = "Invalid json data from server. Please try again later."
    static let somethingWentWrongError = "We had trouble loading your screen. Please try again later."
    static let badRequestError = "Bad request"
    
    //MARK: Contact Details Strings
    static let saturday = "saturday"
    static let sunday = "sunday"
    static let workHourEndMessage = "Work hours has ended. Please contact us again on the next work day"
    static let thankYouMessage = "Thank you for getting in touch with us. We’ll get back to you as soon as possible"
    static let defaultWorkHours = "M-F 9:00 - 18:00"
    static let chatString = "Chat"
    static let callString = "Call"
    static let issueInContactingClinic = "There is some issue connecting clinic. Please try again"
    
    //MARK: API call Endpoints
    static let clinicConfigurationApi = "https://f48ebf51-5871-40b3-9e8d-62d7bbf8a0a4.mock.pstmn.io/config/settings"
    static let clinicPetsInformationApi = "https://40ccaa0a-2010-425a-9260-68294a2e54e2.mock.pstmn.io/petsinfo"
    
    //MARK: table screen model
    static let configScreenModel = "ConfigScreenModel"
    static let petScreenModel = "PetScreenModel"
    
    //MARK: tableview cell identifiers
    static let contactDetailsTableViewCell = "ContactDetailsTableViewCell"
    static let petInfoTableViewCell = "PetInfoTableViewCell"
    
    //MARK: UIAlert action
    static let ok = "OK"
}
