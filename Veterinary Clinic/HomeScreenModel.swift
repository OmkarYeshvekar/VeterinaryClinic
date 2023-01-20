//
//  HomeScreenModel.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 14/01/23.
//

import Foundation


struct ConfigScreenModel {
    var isChatHidden: Bool = false
    var isCallingHidden: Bool = false
    var officeHours: String = StringConstants.defaultWorkHours
}

struct PetsInformationScreenModel {
    var petName: String
    var imageUrl: String
    var contentUrl: String
}
