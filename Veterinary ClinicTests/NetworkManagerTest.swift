//
//  NetworkManagerTest.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 19/01/23.
//

import XCTest
@testable import Veterinary_Clinic

class NetworkManagerTest: XCTestCase {
    
    var networkManager: NetworkManager?
    
    override func setUp() {
        networkManager = NetworkManager()
    }
    
    override func tearDown() {
        networkManager = nil
    }
    
    func test_fetch_ReturnSuccess() {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "MockConfigSettingsResponseModel",
                                                                ofType: "json") else { fatalError("Mock response file not found") }
        

        if let data = try? Data(contentsOf: URL(fileURLWithPath: pathString)) {
            MockURLProtocol.stubResponseData = data
            MockURLProtocol.url = URL(fileURLWithPath: pathString)
            MockURLProtocol.responseStatusCode = 200
        }
        
        guard let url = URL(string: "https://f48ebf51-5871-40b3-9e8d-62d7bbf8a0a4.mock.pstmn.io/config/settings") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.timeoutInterval = 30

        networkManager?.urlRequest = urlRequest
        networkManager?.urlSession = urlSession
        
        let expectation = self.expectation(description: "API call for fetch Success")
        
        networkManager?.fetch(completion: { (data, error) in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            expectation.fulfill()
        })
        self.wait(for: [expectation], timeout: 10)
    }
    
    
    
    func test_fetch_ReturnFailure() {

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        MockURLProtocol.responseStatusCode = 404

        guard let URL = URL(string: "https://f48ebf51-5871-40b3-9e8d-62d7bbf8a0a4.mock.pstmn.io/config/") else { return }
        var urlRequest = URLRequest(url: URL)
        urlRequest.httpMethod = "GET"
        urlRequest.timeoutInterval = 30

        networkManager?.urlRequest = urlRequest
        networkManager?.urlSession = urlSession

        let expectation = self.expectation(description: "API call for fetch Failure")

        networkManager?.fetch(completion: { (data, error) in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.text, "We had trouble loading your screen. Please try again later.")
            
            expectation.fulfill()
        })
        self.wait(for: [expectation], timeout: 10)
    }
    
    
    func test_fetch_ReturnBadRequest() {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        MockURLProtocol.responseStatusCode = 501
        
        guard let URL = URL(string: "https://f48ebf51-5871-40b3-9e8d-62d7bbf8a0a4.mock.pstmn.io/config/settings") else { return }
        var urlRequest = URLRequest(url: URL)
        urlRequest.httpMethod = "GET"
        urlRequest.timeoutInterval = 30

        networkManager?.urlRequest = urlRequest
        networkManager?.urlSession = urlSession

        let expectation = self.expectation(description: "API call for fetch Failure")

        networkManager?.fetch(completion: { (data, error) in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.text, "Bad request")
            
            expectation.fulfill()
        })
        self.wait(for: [expectation], timeout: 10)
    }
}
