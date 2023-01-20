//
//  MockAPIFetcher.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 18/01/23.
//

import Foundation
@testable import Veterinary_Clinic

enum MockAPIFetcherExecutionCases {
    case success
    case failure
}

class MockAPIFetcher: APIFetcherProtocol {
    
    var getClinicConfigurationCalled = false
    var getClinicPetsInformationCalled = false
    var executionCases: MockAPIFetcherExecutionCases = .success
    
    init(executionCases: MockAPIFetcherExecutionCases = .success) {
        self.executionCases = executionCases
    }
    
    func getClinicConfiguration(urlString: String, completion: @escaping (Result<ConfigSettingsResponseModel, APIError>) -> Void) {
        getClinicConfigurationCalled = true
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "MockConfigSettingsResponseModel",
                                                                ofType: "json") else { fatalError("Mock response file not found") }
        
        switch executionCases {
        case .success:
            if let data = try? Data(contentsOf: URL(fileURLWithPath: pathString)) {
                let decoder = JSONDecoder()
                if let jsonData = try? decoder.decode(ConfigSettingsResponseModel.self, from: data) {
                    completion(.success(jsonData))
                }
            }
            
        case .failure:
            completion(.failure(APIError.somethingWentWrong))
        }
    }
    
    func getClinicPetsInformation(urlString: String, completion: @escaping (Result<PetsInformationResponseModel, APIError>) -> Void) {
        getClinicPetsInformationCalled = true
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "MockPetsInformationResponseModel",
                                                                ofType: "json") else { fatalError("Mock response file not found") }
        
        switch executionCases {
        case .success:
            if let data = try? Data(contentsOf: URL(fileURLWithPath: pathString)) {
                let decoder = JSONDecoder()
                if let jsonData = try? decoder.decode(PetsInformationResponseModel.self, from: data) {
                    completion(.success(jsonData))
                }
            }
            
        case .failure:
            completion(.failure(APIError.somethingWentWrong))
        }
    }
                        
}
