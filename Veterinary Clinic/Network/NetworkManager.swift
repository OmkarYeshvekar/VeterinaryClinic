//
//  NetworkManager.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 19/01/23.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetch(completion: @escaping(_ data: Data?, _ error: APIError?) -> Void)
    var urlRequest: URLRequest? { get set }
}


class NetworkManager: NetworkManagerProtocol {
    
    var urlRequest: URLRequest?
    var urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetch(completion: @escaping(_ data: Data?, _ error: APIError?) -> Void) {
        
        guard let request = urlRequest else { return }
        let dataTask = urlSession.dataTask(with: request,
                                           completionHandler: { (data, response, error) in
            
            if error != nil {
                completion(nil, APIError.somethingWentWrong)
            }
            
            let httpResponse = response as? HTTPURLResponse
            
            if let statusCode = httpResponse?.statusCode {
                
                let result = handleNetworkResponse(statusCode: statusCode)
                
                switch result {
                case .success:
                    completion(data, nil)
                    
                case .failure(let error):
                    completion(nil, error)
                }
            }
        })
        dataTask.resume()
    }
}


private enum NetworkResult<APIError> {
    case success
    case failure(APIError)
}

fileprivate func handleNetworkResponse(statusCode: Int) -> NetworkResult<APIError> {
    
    switch statusCode {
    case 200...299: return .success
    case 401...500: return .failure(APIError.somethingWentWrong)
    case 501...599: return .failure(APIError.badRequest)
    default: return .failure(APIError.somethingWentWrong)
    }
}
