//
//  OfficeHourHelperTest.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 25/01/23.
//

import XCTest
@testable import Veterinary_Clinic

class OfficeHourHelperTest: XCTestCase {
    
    var officeHourHelper: OfficeHourHelper?
    
    override func setUp() {
        officeHourHelper = OfficeHourHelper()
    }
    
    override func tearDown() {
        officeHourHelper = nil
    }
    
    func test_OFH() throws {
        let currentDate = getCurrentDate(date: "2023-01-25T13:14:00+0000")
        let message = officeHourHelper?.determineOfficeHours(officeHours: "M-F 9:00 - 17:00",
                                                             currentDate: currentDate)
        XCTAssertEqual(message, StringConstants.workHourEndMessage)
    }
    
    func test_contactWithInOfficeHours() throws {
        let currentDate = getCurrentDate(date: "2023-01-25T10:44:00+0000")
        let message = officeHourHelper?.determineOfficeHours(officeHours: "M-F 9:00 - 18:00",
                                                             currentDate: currentDate)
        XCTAssertEqual(message, StringConstants.thankYouMessage)
    }
    
    func test_checkWeekEnd_OFH() throws {
        let currentDate = getCurrentDate(date: "2023-01-28T19:44:00+0000")
        let message = officeHourHelper?.determineOfficeHours(officeHours: "M-F 9:00 - 18:00",
                                                             currentDate: currentDate)
        XCTAssertEqual(message, StringConstants.workHourEndMessage)
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
