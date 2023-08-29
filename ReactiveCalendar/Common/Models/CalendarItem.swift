//
//  CalendarItem.swift
//  ReactiveCalendar
//
//  Created by Rafał Wojtuś on 29/08/2023.
//

import Foundation

struct CalendarMonth: Equatable {
    let calendarItems: [CalendarItem]
    let monthAndYear: String
}

struct CalendarItem: Equatable {
    let date: Date
    let isCurrentMonth: Bool
}
