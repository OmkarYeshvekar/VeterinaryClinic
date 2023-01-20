//
//  APIErrorMessage.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 17/01/23.
//

import Foundation

enum APIError : Error {
    case noInternet
    case invalidJsonData
    case somethingWentWrong
    case badRequest

    var text : String {
        switch self {
        case .noInternet:
            return "Please check your internet connection or try again later"
        case .invalidJsonData:
            return "Invalid json data from server. Please try again later."
        case .somethingWentWrong:
            return "We had trouble loading your screen. Please try again later."
        case .badRequest:
            return "Bad request"
        }
    }
}
