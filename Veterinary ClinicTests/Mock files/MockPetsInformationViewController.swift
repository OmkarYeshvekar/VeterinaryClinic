//
//  MockPetsInformationViewController.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 19/01/23.
//

import XCTest
@testable import Veterinary_Clinic

class MockPetsInformationViewController: PetsInformationViewControllerProtocol {
    
    var loadWebViewCalled = false
    
    func loadWebView(request: URLRequest) {
        loadWebViewCalled = true
    }
}
