//
//  MockOfficeHourHelper.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 25/01/23.
//

import Foundation
@testable import Veterinary_Clinic

class MockOfficeHourHelper: OfficeHourHelperProtocol {
    
    var determineOfficeHoursCalled = false
    
    func determineOfficeHours(officeHours: String, currentDate: Date) -> String {
        determineOfficeHoursCalled = true
        return ""
    }
}
