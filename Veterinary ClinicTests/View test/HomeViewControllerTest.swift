//
//  HomeViewControllerTest.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 20/01/23.
//

import XCTest
@testable import Veterinary_Clinic

class HomeViewControllerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_checkScreenInitialization() throws {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        sut.loadViewIfNeeded()
        
        let tableView = try XCTUnwrap(sut.tableView, "TableView is not connected to an IBOutlet")
        
        XCTAssertNotNil(tableView.delegate)
        XCTAssertNotNil(sut.viewModel)
    }

}
