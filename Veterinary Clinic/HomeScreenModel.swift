//
//  HomeScreenModel.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 14/01/23.
//

import Foundation


struct ConfigScreenModel {
    var isChatHidden: Bool?
    var isCallingHidden: Bool?
    var officeHours: String?
}

struct PetsInformationScreenModel {
    var petName: String
    var imageUrl: String
    var contentUrl: String
}
