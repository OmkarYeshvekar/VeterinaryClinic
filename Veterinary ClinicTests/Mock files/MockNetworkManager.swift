//
//  MockNetworkManager.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 19/01/23.
//

import Foundation
@testable import Veterinary_Clinic

class MockNetworkManager: NetworkManagerProtocol {
    var urlRequest: URLRequest?
    func fetch(completion: @escaping (Data?, APIError?) -> Void) {
    }
}

class MockNetworkManager_ClinicConfig_Success: NetworkManagerProtocol {
    
    var fetchCalled = false
    var urlRequest: URLRequest?

    func fetch(completion: @escaping (Data?, APIError?) -> Void) {
        fetchCalled = true
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "MockConfigSettingsResponseModel",
                                                                ofType: "json") else { fatalError("Mock response file not found") }
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: pathString)) {
            completion(data, nil)
        }
    }
}


class MockNetworkManager_ClinicConfig_InValidJson: NetworkManagerProtocol {
    
    var fetchCalled = false
    var urlRequest: URLRequest?
    
    func fetch(completion: @escaping (Data?, APIError?) -> Void) {
        fetchCalled = true
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "MockConfigSettingsResponseModel_failure",
                                                                ofType: "json") else { fatalError("Mock response file not found") }
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: pathString)) {
            completion(data, nil)
        }
    }
}

class MockNetworkManager_ClinicConfig_Failure: NetworkManagerProtocol {
    
    var fetchCalled = false
    var urlRequest: URLRequest?
    
    func fetch(completion: @escaping (Data?, APIError?) -> Void) {
        fetchCalled = true
        completion(nil, APIError.somethingWentWrong)
    }
}


class MockNetworkManager_ClinicPetsInformation_Success: NetworkManagerProtocol {
    
    var fetchCalled = false
    var urlRequest: URLRequest?

    func fetch(completion: @escaping (Data?, APIError?) -> Void) {
        fetchCalled = true
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "MockPetsInformationResponseModel",
                                                                ofType: "json") else { fatalError("Mock response file not found") }
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: pathString)) {
            completion(data, nil)
        }
    }
}

class MockNetworkManager_ClinicPetsInformation_InValidJson: NetworkManagerProtocol {
    
    var fetchCalled = false
    var urlRequest: URLRequest?

    func fetch(completion: @escaping (Data?, APIError?) -> Void) {
        fetchCalled = true
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "MockPetsInformationResponseModel_failure",
                                                                ofType: "json") else { fatalError("Mock response file not found") }
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: pathString)) {
            completion(data, nil)
        }
    }
}

class MockNetworkManager_ClinicPetsInformation_Failure: NetworkManagerProtocol {
    
    var fetchCalled = false
    var urlRequest: URLRequest?
    
    func fetch(completion: @escaping (Data?, APIError?) -> Void) {
        fetchCalled = true
        completion(nil, APIError.somethingWentWrong)
    }
}







