//
//  ContactDetailsTableViewCellTest.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 20/01/23.
//

import XCTest
@testable import Veterinary_Clinic

class ContactDetailsTableViewCellTest: XCTestCase {
    
    var tableView: UITableView?
    
    override func setUp() {
        tableView = UITableView()
        tableView?.register(UINib(nibName: StringConstants.contactDetailsTableViewCell, bundle: nil),
                                forCellReuseIdentifier: StringConstants.contactDetailsTableViewCell)
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

    func test_checkContactDetailsCell() throws {

        let cell = tableView?.dequeueReusableCell(withIdentifier: "ContactDetailsTableViewCell") as! ContactDetailsTableViewCell
        cell.awakeFromNib()
        
        let contactMethodButton = try XCTUnwrap(cell.contactMethodButton, "This button is not connected to IBOutlet")
        let callButton = try XCTUnwrap(cell.callButton, "This button is not connected to IBOutlet")
        let chatButton = try XCTUnwrap(cell.chatButton, "This button is not connected to IBOutlet")
        
        XCTAssertNotNil(contactMethodButton)
        XCTAssertNotNil(callButton)
        XCTAssertNotNil(chatButton)
        
        cell.setSelected(true, animated: true)
        
        XCTAssertEqual(contactMethodButton.layer.cornerRadius, 8)
        XCTAssertEqual(callButton.layer.cornerRadius, 8)
        XCTAssertEqual(chatButton.layer.cornerRadius, 8)
    }
    
    func test_contactDetailsCell_setArrangeContactButtons() {
        
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ContactDetailsTableViewCell") as! ContactDetailsTableViewCell
        cell.awakeFromNib()
        
        cell.setArrangeContactButtons(data: setConfigScreenModel(isChatHidden: true, isCallingHidden: true))
        XCTAssertTrue(cell.contactMethodButton.isHidden)
        XCTAssertTrue(cell.innerView.isHidden)

        cell.setArrangeContactButtons(data: setConfigScreenModel(isChatHidden: false, isCallingHidden: false))
        XCTAssertTrue(cell.contactMethodButton.isHidden)

        cell.setArrangeContactButtons(data: setConfigScreenModel(isChatHidden: false, isCallingHidden: true))
        XCTAssertTrue(cell.innerView.isHidden)
        XCTAssertEqual(cell.contactMethodButton.titleLabel?.text, StringConstants.chatString)
        
        cell.setArrangeContactButtons(data: setConfigScreenModel(isChatHidden: true, isCallingHidden: false))
        XCTAssertTrue(cell.innerView.isHidden)
        XCTAssertEqual(cell.contactMethodButton.titleLabel?.text, StringConstants.callString)        
    }
    
    
    
    
    private func setConfigScreenModel(isChatHidden: Bool, isCallingHidden: Bool) -> ConfigScreenModel {
        
        let config = ConfigScreenModel(isChatHidden: isChatHidden,
                                       isCallingHidden: isCallingHidden,
                                       officeHours: StringConstants.defaultWorkHours)
        return config
    }
    

}
