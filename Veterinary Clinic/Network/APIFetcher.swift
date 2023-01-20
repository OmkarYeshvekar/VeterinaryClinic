//
//  APIFetcher.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 16/01/23.
//

import Foundation

protocol APIFetcherProtocol {
    func getClinicConfiguration(urlString: String, completion: @escaping (Result<ConfigSettingsResponseModel, APIError>) -> Void)
    func getClinicPetsInformation(urlString: String, completion: @escaping (Result<PetsInformationResponseModel, APIError>) -> Void)
}


class APIFetcher: APIFetcherProtocol {
    
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getClinicConfiguration(urlString: String, completion: @escaping (Result<ConfigSettingsResponseModel, APIError>) -> Void) {
        
        guard let URL = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: URL)
        urlRequest.httpMethod = "GET"
        urlRequest.timeoutInterval = 30
        
        networkManager.urlRequest = urlRequest
        
        networkManager.fetch(completion: { (data, error) in
            
            if error != nil {
                completion(.failure(error ?? APIError.somethingWentWrong))
            }
            
            if let responseData = data {
                do {
                    let decoder = JSONDecoder()
                    let information = try decoder.decode(ConfigSettingsResponseModel.self, from: responseData)
                    completion(.success(information))
                    
                } catch {
                    debugPrint("Parsing error: ", error)
                    completion(.failure(APIError.invalidJsonData))
                }
            }
        })
    }
    
    
    func getClinicPetsInformation(urlString: String, completion: @escaping (Result<PetsInformationResponseModel, APIError>) -> Void) {
        
        guard let URL = URL(string: urlString) else { return }
        
        var urlRequest = URLRequest(url: URL)
        urlRequest.httpMethod = "GET"
        urlRequest.timeoutInterval = 30
        
        networkManager.urlRequest = urlRequest
        
        networkManager.fetch(completion: { (data, error) in
            
            if error != nil {
                completion(.failure(error ?? APIError.somethingWentWrong))
            }
            
            if let responseData = data {
                do {
                    let decoder = JSONDecoder()
                    let information = try decoder.decode(PetsInformationResponseModel.self, from: responseData)
                    completion(.success(information))
                    
                } catch {
                    debugPrint("Parsing error: ", error)
                    completion(.failure(APIError.invalidJsonData))
                }
            }
        })
    }
}
