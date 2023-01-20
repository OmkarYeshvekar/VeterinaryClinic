//
//  Date+ExtensionTest.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 19/01/23.
//

import XCTest
@testable import Veterinary_Clinic

class Date_ExtensionTest: XCTestCase {
    
    var currentDate: Date?
    
    override func setUp() {
        currentDate = Date()
    }
    
    override func tearDown() {
        currentDate = nil
    }
    
    func test_dateAt() {
        
        let requiredHours = currentDate?.dateAt(hours: 15, minutes: 00) ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let resultTimeInString = dateFormatter.string(from: requiredHours)
        
        XCTAssertEqual(resultTimeInString, "15:00")
    }

}
