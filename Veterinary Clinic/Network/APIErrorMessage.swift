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
            return StringConstants.noInternetError
        case .invalidJsonData:
            return StringConstants.invalidJsonError
        case .somethingWentWrong:
            return StringConstants.somethingWentWrongError
        case .badRequest:
            return StringConstants.badRequestError
        }
    }
}
