//
//  UIImageExtension.swift
//  ReactiveCalendar
//
//  Created by Rafał Wojtuś on 29/08/2023.
//

import UIKit

extension UIImage {
    static func systemImageName(_ name: SystemImage) -> UIImage? {
        return UIImage(systemName: name.rawValue)
    }
}

enum SystemImage: String {
    case calendarIcon = "calendar"
    case homeIcon = "house"
    case settingsIcon = "gearshape"
}
