import UIKit
import RxSwift

protocol HasAppNavigation {
    var appNavigation: AppNavigation? { get }
}

protocol AppNavigation: AnyObject {
    func startApplication()
}

final class MainFlowController: AppNavigation {
    typealias Dependencies = HasNavigation
    
    struct ExtendedDependencies: Dependencies, HasAppNavigation{
        private let dependencies: Dependencies
        weak var appNavigation: AppNavigation?
        var navigation: Navigation { dependencies.navigation }
        
        init(dependencies: Dependencies, appNavigation: AppNavigation) {
            self.dependencies = dependencies
            self.appNavigation = appNavigation
        }
    }
    
    // MARK: - Properties
    
    private let dependencies: Dependencies
    // swiftlint:disable: redundant_type_annotation
    private lazy var extendedDependencies: ExtendedDependencies = ExtendedDependencies(dependencies: dependencies, appNavigation: self)
    // swiftlint:enable: redundant_type_annotation
    
    // MARK: - Builders
    private lazy var calendarScreenBuilder: CalendarScreenBuilder = CalendarScreenBuilderImpl(dependencies: extendedDependencies)

    // MARK: - Initialization
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - AppNavigation
    func startApplication() {
        showCalendarScreen()
    }
    
    private func showCalendarScreen() {
        let view = calendarScreenBuilder.build(with: .init()).view
        dependencies.navigation.set(view: view, animated: true)
    }
    // swiftlint:disable:next file_length
}
