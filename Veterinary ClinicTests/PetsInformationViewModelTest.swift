//
//  PetsInformationViewModelTest.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 19/01/23.
//

import XCTest
@testable import Veterinary_Clinic

class PetsInformationViewModelTest: XCTestCase {
    
    var petsInformationViewModel: PetsInformationViewModel?
    let contentUrl = "https://en.wikipedia.org/wiki/Cat"
    var mockPetsInformationViewController: MockPetsInformationViewController?
    
    override func setUp() {
        petsInformationViewModel = PetsInformationViewModel(contentUrl: contentUrl)
        mockPetsInformationViewController = MockPetsInformationViewController()
        petsInformationViewModel?.view = mockPetsInformationViewController
    }
    
    override func tearDown() {
        petsInformationViewModel = nil
        mockPetsInformationViewController = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_configUrlForWebView() {
        petsInformationViewModel?.configUrlForWebView()
        XCTAssertTrue(mockPetsInformationViewController?.loadWebViewCalled ?? false)
    }

}
