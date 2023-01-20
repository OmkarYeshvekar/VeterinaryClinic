//
//  APIFetchertest.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 18/01/23.
//

import XCTest
@testable import Veterinary_Clinic

class APIFetchertest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_getClinicConfiguration_success() {

        let mockNetworkManager = MockNetworkManager_ClinicConfig_Success()
        
        let sut = APIFetcher(networkManager: mockNetworkManager)
        let expectation = self.expectation(description: "API call for getting Clinic Configuration details")
        
        let urlString = "https://f48ebf51-5871-40b3-9e8d-62d7bbf8a0a4.mock.pstmn.io/config/settings"
        sut.getClinicConfiguration(urlString: urlString, completion: { result in
            
            switch result {
            case .success(let response):
                XCTAssertNotNil(response.settings)
                expectation.fulfill()
            case .failure(_): break
            }
        })
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func test_getClinicConfiguration_failure_invalidJson() {
        
        let mockNetworkManager = MockNetworkManager_ClinicConfig_InValidJson()
        
        let sut = APIFetcher(networkManager: mockNetworkManager)
        let expectation = self.expectation(description: "API call for getting Clinic Configuration details")

        let urlString = "https://f48ebf51-5871-40b3-9e8d-62d7bbf8a0a4.mock.pstmn.io/config/settings"
        sut.getClinicConfiguration(urlString: urlString, completion: { result in

            switch result {
            case .success(_): break
            case .failure(let error):
                XCTAssertEqual(error.text, "Invalid json data from server. Please try again later.")
                expectation.fulfill()
            }
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    
    func test_getClinicConfiguration_failure() {
        
        let mockNetworkManager = MockNetworkManager_ClinicConfig_Failure()
        
        let sut = APIFetcher(networkManager: mockNetworkManager)
        let expectation = self.expectation(description: "API call for getting Clinic Configuration details")

        let urlString = "https://f48ebf51-5871-40b3-9e8d-62d7bbf8a0a4.mock.pstmn.io/config/settings"
        sut.getClinicConfiguration(urlString: urlString, completion: { result in

            switch result {
            case .success(_): break
            case .failure(let error):
                XCTAssertEqual(error.text, "We had trouble loading your screen. Please try again later.")
                expectation.fulfill()
            }
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    
    
    
    func test_getClinicPetsInformation_success() {

        let mockNetworkManager = MockNetworkManager_ClinicPetsInformation_Success()

        let sut = APIFetcher(networkManager: mockNetworkManager)
        let expectation = self.expectation(description: "API call for getting pets information details")

        let urlString = "https://40ccaa0a-2010-425a-9260-68294a2e54e2.mock.pstmn.io/petsinfo"
        sut.getClinicPetsInformation(urlString: urlString, completion: { result in

            switch result {
            case .success(let response):
                XCTAssertNotNil(response.pets)
                XCTAssertEqual(response.pets.count, 10)
                expectation.fulfill()

            case .failure(_): break
            }
        })
        self.wait(for: [expectation], timeout: 5)
    }
    
    
    
    func test_getClinicPetsInformation_InvalidJson() {
        
        let mockNetworkManager = MockNetworkManager_ClinicPetsInformation_InValidJson()

        let sut = APIFetcher(networkManager: mockNetworkManager)
        let expectation = self.expectation(description: "API call for getting pets information details")

        let urlString = "https://40ccaa0a-2010-425a-9260-68294a2e54e2.mock.pstmn.io/petsinfo"
        sut.getClinicPetsInformation(urlString: urlString, completion: { result in

            switch result {
            case .success(_): break
            case .failure(let error):
                XCTAssertEqual(error.text, "Invalid json data from server. Please try again later.")
                expectation.fulfill()
            }
        })
        self.wait(for: [expectation], timeout: 5)
    }
    
    func test_getClinicPetsInformation_failure() {
        
        let mockNetworkManager = MockNetworkManager_ClinicPetsInformation_Failure()
        
        let sut = APIFetcher(networkManager: mockNetworkManager)
        let expectation = self.expectation(description: "API call for getting Clinic Configuration details")

        let urlString = "https://f48ebf51-5871-40b3-9e8d-62d7bbf8a0a4.mock.pstmn.io/config/settings"
        sut.getClinicConfiguration(urlString: urlString, completion: { result in

            switch result {
            case .success(_): break
            case .failure(let error):
                XCTAssertEqual(error.text, "We had trouble loading your screen. Please try again later.")
                expectation.fulfill()
            }
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
}
