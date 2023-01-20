//
//  Date+Extension.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 17/01/23.
//

import Foundation

extension Date {
    
    func dateAt(hours: Int, minutes: Int) -> Date {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        var date_components = calendar.components([.year, .month, .day], from: self)
        
        //Create an NSDate for the specified time today.
        date_components.hour = hours
        date_components.minute = minutes
        date_components.second = 0
        
        return calendar.date(from: date_components)!
    }
}
