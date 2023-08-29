//
//  CalendarScreenContract.swift
//  ReactiveCalendar
//
//  Created by Rafał Wojtuś on 29/08/2023.
//

import RxSwift

enum CalendarScreenIntent {
}

struct CalendarScreenViewState: Equatable {
}

enum CalendarScreenEffect: Equatable {
}

struct CalendarScreenBuilderInput {
}

protocol CalendarScreenCallback {
}

enum CalendarScreenResult: Equatable {
    case partialState(_ value: CalendarScreenPartialState)
    case effect(_ value: CalendarScreenEffect)
}

enum CalendarScreenPartialState: Equatable {
    func reduce(previousState: CalendarScreenViewState) -> CalendarScreenViewState {
        var state = previousState
        switch self {
        }
        return state
    }
}

protocol CalendarScreenBuilder {
    func build(with input: CalendarScreenBuilderInput) -> CalendarScreenModule
}

struct CalendarScreenModule {
    let view: CalendarScreenView
    let callback: CalendarScreenCallback
}

protocol CalendarScreenView: BaseView {
    var intents: Observable<CalendarScreenIntent> { get }
    func render(state: CalendarScreenViewState)
}

protocol CalendarScreenPresenter: AnyObject, BasePresenter {
    func bindIntents(view: CalendarScreenView, triggerEffect: PublishSubject<CalendarScreenEffect>) -> Observable<CalendarScreenViewState>
}

protocol CalendarScreenInteractor: BaseInteractor {
}

protocol CalendarScreenMiddleware {
    var middlewareObservable: Observable<CalendarScreenResult> { get }
    func process(result: CalendarScreenResult) -> Observable<CalendarScreenResult>
}
