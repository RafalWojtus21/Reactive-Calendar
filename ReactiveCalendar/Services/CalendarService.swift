//
//  CalendarService.swift
//  ReactiveCalendar
//
//  Created by Rafał Wojtuś on 29/08/2023.
//

import Foundation
import RxSwift
import RxRelay

protocol HasCalendarService {
    var calendarService: CalendarService { get }
}

protocol CalendarService {
    func triggerPreviousMonth() -> Completable
    func triggerNextMonth() -> Completable
    func switchMonth(offset: Int) -> Completable
    func generateCalendarMonths() -> Observable<[CalendarMonth]>
}

final class CalendarServiceImpl: CalendarService {
    
    // MARK: Properties

    private let bag = DisposeBag()
    private let calendar = Calendar.current
    var monthIndexTracker = BehaviorRelay<Int>(value: 0)
    var monthNameTracker = BehaviorRelay<String>(value: "")
    
    // MARK: Initialization
    
    init() {}

    // MARK: Public Implementation

    func triggerNextMonth() -> Completable {
        return Completable.create { completable in
            self.monthIndexTracker.accept(self.monthIndexTracker.value + 1)
            completable(.completed)
            return Disposables.create()
        }
    }
    
    func triggerPreviousMonth() -> Completable {
        return Completable.create { completable in
            self.monthIndexTracker.accept(self.monthIndexTracker.value - 1)
            completable(.completed)
            return Disposables.create()
        }
    }
    
    func switchMonth(offset: Int) -> Completable {
        return Completable.create { completable in
            self.monthIndexTracker.accept(offset)
            completable(.completed)
            return Disposables.create()
        }
    }
    
    func generateCalendarMonths() -> Observable<[CalendarMonth]> {
        let chosenMonthDate = self.getChosenMonth()
        let calendarMonths = self.generateCalendarMonths(for: chosenMonthDate)
        return Observable.just(calendarMonths)
    }
    
    // MARK: Private Implementation
    
    private func getChosenMonth() -> Date {
        let referenceDate = Date()
        let difference = monthIndexTracker.value
        guard let chosenMonthDate = calendar.date(byAdding: .month, value: difference, to: referenceDate) else { return Date() }
        return chosenMonthDate
    }
    
    private func generateCalendarMonths(for chosenMonthDate: Date) -> [CalendarMonth] {
        let months = getFirstDayOfCurrentAndAdjacentMonths(chosenMonthDate)
        let calendarMonths = months.map { month -> CalendarMonth in
            let calendarItems = generateCalendarItems(for: month)
            let monthAndYear = getMonthAndYearName(date: month)
            return CalendarMonth(calendarItems: calendarItems, monthAndYear: monthAndYear)
        }
        return calendarMonths
    }

    private func generateCalendarItems(for month: Date) -> [CalendarItem] {
        let offset = calendar.component(.weekday, from: month) - 2
        let numberOfItemsInCollectionView = 35
        let calendarItems = (0 ..< numberOfItemsInCollectionView).compactMap { index -> CalendarItem? in
            guard let date = calendar.date(byAdding: .day, value: index - offset, to: month) else {
                return nil
            }
            let isCurrentMonth = isDateInCurrentMonth(date, currentMonthDate: month)
            return CalendarItem(date: date, isCurrentMonth: isCurrentMonth)
        }
        return calendarItems
    }
    
    private func getMonthAndYearName(date: Date) -> String {
        let currentMonthName = DateFormatter.monthStringYearDateFormatter.string(from: date)
        monthNameTracker.accept(currentMonthName)
        return currentMonthName
    }
    
    private func getFirstDayOfCurrentAndAdjacentMonths(_ date: Date) -> [Date] {
        let offsetRange = -2...2
        return offsetRange.compactMap { getFirstDayOfMonthForOffset(date: date, offset: $0) }
    }
    
    private func getFirstDayOfMonthForOffset(date: Date, offset: Int) -> Date? {
        guard let monthDate = calendar.date(byAdding: .month, value: offset, to: date)
        else { return nil }
        let components = calendar.dateComponents([.year, .month], from: monthDate)
        let firstDayOfMonth = calendar.date(from: components)
        return firstDayOfMonth
    }
    
    private func isDateInCurrentMonth(_ date: Date, currentMonthDate: Date) -> Bool {
        let currentMonth = calendar.component(.month, from: currentMonthDate)
        let targetMonth = calendar.component(.month, from: date)
        return currentMonth == targetMonth
    }
}
