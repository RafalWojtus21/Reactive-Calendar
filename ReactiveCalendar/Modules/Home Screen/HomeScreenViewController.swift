//
//  HomeScreenViewController.swift
//  ReactiveCalendar
//
//  Created by Rafał Wojtuś on 29/08/2023.
//

import Foundation

final class HomeScreenViewController: BaseViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
    }
    
    // MARK: Private Implementation
    
    private func layoutViews() {
        view.backgroundColor = .primaryColor
    }
}
