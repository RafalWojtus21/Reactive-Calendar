//
//  CalendarScreenInteractor.swift
//  ReactiveCalendar
//
//  Created by Rafał Wojtuś on 29/08/2023.
//

import RxSwift

final class CalendarScreenInteractorImpl: CalendarScreenInteractor {
    
    // MARK: Properties
    
    typealias Dependencies = Any
    typealias Result = CalendarScreenResult
    
    private let dependencies: Dependencies
    
    // MARK: Initialization

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: Public Implementation
    
    // MARK: Private Implementation
}
