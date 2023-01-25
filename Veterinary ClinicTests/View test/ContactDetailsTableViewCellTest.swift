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
        
        cell.setArrangeContactButtons(data: setConfigScreenModel(isChatEnabled: true, isCallingEnabled: true))
        XCTAssertTrue(cell.contactMethodButton.isHidden)
        XCTAssertFalse(cell.innerView.isHidden)

        cell.setArrangeContactButtons(data: setConfigScreenModel(isChatEnabled: false, isCallingEnabled: false))
        XCTAssertTrue(cell.contactMethodButton.isHidden)
        XCTAssertTrue(cell.innerView.isHidden)

        cell.setArrangeContactButtons(data: setConfigScreenModel(isChatEnabled: false, isCallingEnabled: true))
        XCTAssertTrue(cell.innerView.isHidden)
        XCTAssertEqual(cell.contactMethodButton.titleLabel?.text, StringConstants.callString)
        
        cell.setArrangeContactButtons(data: setConfigScreenModel(isChatEnabled: true, isCallingEnabled: false))
        XCTAssertTrue(cell.innerView.isHidden)
        XCTAssertEqual(cell.contactMethodButton.titleLabel?.text, StringConstants.chatString)
    }
    
    
    func test_contactMethodButton_checkForWeekEnd_OFH() throws {
        var contactMethodButtonClicked = false
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ContactDetailsTableViewCell") as! ContactDetailsTableViewCell
        cell.awakeFromNib()

        let contactMethodButton = try XCTUnwrap(cell.contactMethodButton, "This button is not connected to IBOutlet")
        
        let expectation = self.expectation(description: "call contactMethodButtonClicked")
        cell.contactMethodButtonClicked = {
            contactMethodButtonClicked = true
            expectation.fulfill()
        }
        
        if let action = contactMethodButton.actions(forTarget: cell, forControlEvent: .touchUpInside) {
            XCTAssertEqual(action.count, 1)
            XCTAssertEqual(action.first, "contactMethodButtonClicked:", "There is no any such action attached with name contactMethodButtonClicked:")
        }
        
        cell.contactMethodButtonClicked(contactMethodButton)
        self.wait(for: [expectation], timeout: 10)
        XCTAssertTrue(contactMethodButtonClicked)
    }

    func test_chatButton_contactWithInOfficeHours() throws {
        var chatButtonClicked = false
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ContactDetailsTableViewCell") as! ContactDetailsTableViewCell
        cell.awakeFromNib()

        let chatButton = try XCTUnwrap(cell.chatButton, "This button is not connected to IBOutlet")
        
        let expectation = self.expectation(description: "call chatButtonClicked")
        cell.chatButtonClicked = {
            chatButtonClicked = true
            expectation.fulfill()
        }
        
        if let action = chatButton.actions(forTarget: cell, forControlEvent: .touchUpInside) {
            XCTAssertEqual(action.count, 1)
            XCTAssertEqual(action.first, "chatButtonClicked:", "There is no any such action attached with name chatButtonClicked:")
        }

        cell.chatButtonClicked(chatButton)
        self.wait(for: [expectation], timeout: 10)
        XCTAssertTrue(chatButtonClicked)
    }

    
    func test_callButton_contactOFH() throws {
        var callButtonClicked = false
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ContactDetailsTableViewCell") as! ContactDetailsTableViewCell
        cell.awakeFromNib()

        let callButton = try XCTUnwrap(cell.callButton, "This button is not connected to IBOutlet")
        
        let expectation = self.expectation(description: "call chatButtonClicked")
        cell.callButtonClicked = {
            callButtonClicked = true
            expectation.fulfill()
        }
        
        if let action = callButton.actions(forTarget: cell, forControlEvent: .touchUpInside) {
            XCTAssertEqual(action.count, 1)
            XCTAssertEqual(action.first, "callButtonClicked:", "There is no any such action attached with name callButtonClicked:")
        }
         
        cell.callButtonClicked(callButton)
        self.wait(for: [expectation], timeout: 10)
        XCTAssertTrue(callButtonClicked)
    }
    
    
    private func setConfigScreenModel(isChatEnabled: Bool, isCallingEnabled: Bool) -> ConfigScreenModel {
        
        let config = ConfigScreenModel(isChatEnabled: isChatEnabled,
                                       isCallEnabled: isCallingEnabled,
                                       officeHours: StringConstants.defaultWorkHours)
        return config
    }
    
    private func getCurrentDate(date: String) -> Date {
        let isoDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        return date
    }
    

}
