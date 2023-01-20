//
//  ConfigSettingsResponseModel.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 16/01/23.
//

import Foundation

struct ConfigSettingsResponseModel: Codable {
    let settings: Settings
}

struct Settings: Codable {
    let isChatEnabled: Bool?
    let isCallEnabled: Bool?
    let workHours: String?
}
