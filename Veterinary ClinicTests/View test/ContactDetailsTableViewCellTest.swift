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
    
    
    func test_contactMethodButton_checkForWeekEnd_OFH() throws {
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ContactDetailsTableViewCell") as! ContactDetailsTableViewCell
        cell.awakeFromNib()

        let contactMethodButton = try XCTUnwrap(cell.contactMethodButton, "This button is not connected to IBOutlet")
        
        cell.contactMethodButtonClicked = { message in
            XCTAssertEqual(message, StringConstants.workHourEndMessage)
        }
        
        if let action = contactMethodButton.actions(forTarget: cell, forControlEvent: .touchUpInside) {
            XCTAssertEqual(action.count, 1)
            XCTAssertEqual(action.first, "contactMethodButtonClicked:", "There is no any such action attached with name contactMethodButtonClicked:")
        }
        
        cell.currentDate = getCurrentDate(date: "2023-01-22T10:44:00+0000")
         
        cell.contactMethodButtonClicked(contactMethodButton)
    }
    
    func test_chatButton_contactWithInOfficeHours() throws {
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ContactDetailsTableViewCell") as! ContactDetailsTableViewCell
        cell.awakeFromNib()

        let chatButton = try XCTUnwrap(cell.chatButton, "This button is not connected to IBOutlet")
        
        cell.chatButtonClicked = { message in
            XCTAssertEqual(message, StringConstants.thankYouMessage)
        }
        
        if let action = chatButton.actions(forTarget: cell, forControlEvent: .touchUpInside) {
            XCTAssertEqual(action.count, 1)
            XCTAssertEqual(action.first, "chatButtonClicked:", "There is no any such action attached with name chatButtonClicked:")
        }
        
        cell.currentDate = getCurrentDate(date: "2023-01-23T10:44:00+0000")
         
        cell.chatButtonClicked(chatButton)
    }
    
    
    
    func test_callButton_contactOFH() throws {
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ContactDetailsTableViewCell") as! ContactDetailsTableViewCell
        cell.awakeFromNib()

        let callButton = try XCTUnwrap(cell.callButton, "This button is not connected to IBOutlet")
        
        cell.callButtonClicked = { message in
            XCTAssertEqual(message, StringConstants.workHourEndMessage)
        }
        
        if let action = callButton.actions(forTarget: cell, forControlEvent: .touchUpInside) {
            XCTAssertEqual(action.count, 1)
            XCTAssertEqual(action.first, "callButtonClicked:", "There is no any such action attached with name callButtonClicked:")
        }
        
        cell.currentDate = getCurrentDate(date: "2023-01-23T19:44:00+0000")
         
        cell.callButtonClicked(callButton)
    }
    
    
    
    private func setConfigScreenModel(isChatHidden: Bool, isCallingHidden: Bool) -> ConfigScreenModel {
        
        let config = ConfigScreenModel(isChatHidden: isChatHidden,
                                       isCallingHidden: isCallingHidden,
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
