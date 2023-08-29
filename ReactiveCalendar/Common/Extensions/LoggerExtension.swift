//
//  LoggerExtension.swift
//  ReactiveCalendar
//
//  Created by Rafał Wojtuś on 29/08/2023.
//

import Foundation
import OSLog
typealias Log = Logger

extension Logger {
    // swiftlint:disable:next force_unwrapping
    private static let subsystem = Bundle.main.bundleIdentifier!
    
    static let workoutCreator = Logger(subsystem: subsystem, category: "workoutCreator")
    static let trainingAssistant = Logger(subsystem: subsystem, category: "trainingAssistant")
    static let calendar = Logger(subsystem: subsystem, category: "calendar")
}
