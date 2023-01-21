//
//  PetInfoTableViewCellTest.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 21/01/23.
//

import XCTest
@testable import Veterinary_Clinic

class PetInfoTableViewCellTest: XCTestCase {

    var tableView: UITableView?
    
    override func setUp() {
        tableView = UITableView()
        tableView?.register(UINib(nibName: StringConstants.petInfoTableViewCell, bundle: nil),
                            forCellReuseIdentifier: StringConstants.petInfoTableViewCell)
    }
    
    override func tearDown() {
        tableView = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_checkPetsInfoCell() throws {
        
        let cell = tableView?.dequeueReusableCell(withIdentifier: "PetInfoTableViewCell") as! PetInfoTableViewCell
        cell.awakeFromNib()
        
        let petImageView = try XCTUnwrap(cell.petImageView, "This imageview is not connected to IBOutlet")
        let petName = try XCTUnwrap(cell.petName, "This label is not connected to IBOutlet")
        
        cell.setSelected(true, animated: true)
        
        XCTAssertNotNil(petImageView)
        XCTAssertNotNil(petName)
    }
}
