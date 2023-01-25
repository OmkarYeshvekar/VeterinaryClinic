//
//  OfficeHoursHelper.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 25/01/23.
//

import Foundation

protocol OfficeHourHelperProtocol {
    func determineOfficeHours(officeHours: String, currentDate: Date) -> String
}

private enum Days: String {

    case Su = "Su"
    case M = "M"
    case Tu = "Tu"
    case W = "W"
    case Th = "Th"
    case F = "F"
    case Sa = "Sa"
    
    var dayNumber: Int {
        switch self {
        case .Su:
            return 1
        case .M:
            return 2
        case .Tu:
            return 3
        case .W:
            return 4
        case .Th:
            return 5
        case .F:
            return 6
        case .Sa:
            return 7
        }
    }
}

class OfficeHourHelper: OfficeHourHelperProtocol {
    
    func determineOfficeHours(officeHours: String, currentDate: Date) -> String {
        
        let splitOfficeHour = officeHours.split(separator: " ")
        
        let filteredHours = splitOfficeHour.filter({ item in
            item == "-" ? false : true
        })
        
        let workHoursString = filteredHours[0]
        let openingTime = filteredHours[1]
        let closingTime = filteredHours[2]
        
        
        let splitWorkHours = workHoursString.description.split(separator: "-")
        guard let startDay = Days(rawValue: splitWorkHours[0].description)?.dayNumber,
                let endDay = Days(rawValue: splitWorkHours[1].description)?.dayNumber else {
            return StringConstants.issueInContactingClinic
        }
        
        let currentDay = getDayFromCalender(currentDate: currentDate)
                
        if currentDay >= startDay && currentDay <= endDay  {
            //NOTE: WithIn Office hours.
            let openHours = getClinicHours(currentDate: currentDate, timings: openingTime)
            let closeHours = getClinicHours(currentDate: currentDate, timings: closingTime)
            return compareAndGetMessageString(currentDate: currentDate, openHours: openHours, closeHours: closeHours)
            
        } else {
            //NOTE: Out of office hours.
            return StringConstants.workHourEndMessage
        }
    }
    
    private func getDayFromCalender(currentDate: Date) -> Int {
        
        let calender = Calendar.current
        let weekDateComponent = calender.dateComponents([.weekday], from: currentDate)
        guard let currentDay = weekDateComponent.weekday else { return 0 }
        return currentDay
    }
    
    private func getClinicHours(currentDate: Date, timings: Substring.SubSequence) -> Date {
        
        let splitTiming = timings.split(separator: ":")
        guard let hour = Int(splitTiming[0].description),
              let min = Int(splitTiming[1].description) else { return currentDate }
        let clinicTiming = getClinicTimings(currentDate: currentDate,
                                            hours: hour, minutes: min)
        return clinicTiming
    }
    
    private func getClinicTimings(currentDate: Date, hours: Int, minutes: Int) -> Date {
        return currentDate.dateAt(hours: hours, minutes: minutes)
    }
    
    private func compareAndGetMessageString(currentDate: Date, openHours: Date, closeHours: Date) -> String {
        
        if currentDate >= openHours && currentDate <= closeHours {
            return StringConstants.thankYouMessage
        } else {
            return StringConstants.workHourEndMessage
        }
    }
}
