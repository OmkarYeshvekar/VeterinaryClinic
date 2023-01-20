//
//  PetsInformationResponseModel.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 16/01/23.
//

import Foundation

struct PetsInformationResponseModel: Codable {
    let pets: [Pets]
}

struct Pets: Codable {
    let image_url: String?
    let title: String?
    let content_url: String?
    let date_added: String?
}
