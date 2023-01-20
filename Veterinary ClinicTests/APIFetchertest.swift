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
        
        let urlString = StringConstants.clinicConfigurationApi
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

        let urlString = StringConstants.clinicConfigurationApi
        sut.getClinicConfiguration(urlString: urlString, completion: { result in

            switch result {
            case .success(_): break
            case .failure(let error):
                XCTAssertEqual(error.text, StringConstants.invalidJsonError)
                expectation.fulfill()
            }
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    
    func test_getClinicConfiguration_failure() {
        
        let mockNetworkManager = MockNetworkManager_ClinicConfig_Failure()
        
        let sut = APIFetcher(networkManager: mockNetworkManager)
        let expectation = self.expectation(description: "API call for getting Clinic Configuration details")

        let urlString = StringConstants.clinicConfigurationApi
        sut.getClinicConfiguration(urlString: urlString, completion: { result in

            switch result {
            case .success(_): break
            case .failure(let error):
                XCTAssertEqual(error.text, StringConstants.somethingWentWrongError)
                expectation.fulfill()
            }
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
    
    
    
    func test_getClinicPetsInformation_success() {

        let mockNetworkManager = MockNetworkManager_ClinicPetsInformation_Success()

        let sut = APIFetcher(networkManager: mockNetworkManager)
        let expectation = self.expectation(description: "API call for getting pets information details")

        let urlString = StringConstants.clinicPetsInformationApi
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

        let urlString = StringConstants.clinicPetsInformationApi
        sut.getClinicPetsInformation(urlString: urlString, completion: { result in

            switch result {
            case .success(_): break
            case .failure(let error):
                XCTAssertEqual(error.text, StringConstants.invalidJsonError)
                expectation.fulfill()
            }
        })
        self.wait(for: [expectation], timeout: 5)
    }
    
    func test_getClinicPetsInformation_failure() {
        
        let mockNetworkManager = MockNetworkManager_ClinicPetsInformation_Failure()
        
        let sut = APIFetcher(networkManager: mockNetworkManager)
        let expectation = self.expectation(description: "API call for getting Clinic Configuration details")

        let urlString = StringConstants.clinicConfigurationApi
        sut.getClinicConfiguration(urlString: urlString, completion: { result in

            switch result {
            case .success(_): break
            case .failure(let error):
                XCTAssertEqual(error.text, StringConstants.somethingWentWrongError)
                expectation.fulfill()
            }
        })

        self.wait(for: [expectation], timeout: 5)
    }
    
}
