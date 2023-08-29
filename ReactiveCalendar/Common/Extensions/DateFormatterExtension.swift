//
//  DateFormatterExtension.swift
//  ReactiveCalendar
//
//  Created by Rafał Wojtuś on 29/08/2023.
//

import Foundation

extension DateFormatter {
    
    enum DateFormat: String {
        case monthStringYear = "MMMM yyyy"
    }
    
    static var monthStringYearDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.monthStringYear.rawValue
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()
}
