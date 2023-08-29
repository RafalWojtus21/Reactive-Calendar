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
    
    struct ExtendedDependencies: Dependencies, HasAppNavigation, HasCalendarService {
        private let dependencies: Dependencies
        weak var appNavigation: AppNavigation?
        var navigation: Navigation { dependencies.navigation }
        let calendarService: CalendarService
        
        init(dependencies: Dependencies, appNavigation: AppNavigation) {
            self.dependencies = dependencies
            self.appNavigation = appNavigation
            self.calendarService = CalendarServiceImpl()
        }
    }
    
    // MARK: - Properties
    
    private let dependencies: Dependencies
    // swiftlint:disable:next redundant_type_annotation
    private lazy var extendedDependencies: ExtendedDependencies = ExtendedDependencies(dependencies: dependencies, appNavigation: self)
    
    // MARK: - Builders
    private lazy var calendarScreenBuilder: CalendarScreenBuilder = CalendarScreenBuilderImpl(dependencies: extendedDependencies)

    // MARK: - Initialization
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - AppNavigation
    
    func startApplication() {
        dependencies.navigation.setTabBar(viewControllers: tabBarViewControllers(), animated: true, selectedTab: 0)
    }
    
    private func tabBarViewControllers() -> [UINavigationController] {
        let calendarScreen = calendarScreenBuilder.build(with: .init()).view
        let homeScreen = calendarScreenBuilder.build(with: .init()).view
        let settingsScreen = calendarScreenBuilder.build(with: .init()).view
        
        let tabBarScreens = [calendarScreen, homeScreen, settingsScreen]
        let tabBarTitles = ["Calendar", "Home", "Settings"]
        let tabBarIcons: [UIImage?] = [.systemImageName(SystemImage.calendarIcon), .systemImageName(SystemImage.homeIcon), .systemImageName(SystemImage.settingsIcon)]
        
        var viewControllers = [UINavigationController]()
        for index in 0 ..< tabBarScreens.count {
            let navigationController = UINavigationController(rootViewController: tabBarScreens[index] as? UIViewController ?? UIViewController())
            navigationController.tabBarItem = UITabBarItem(title: tabBarTitles[index], image: tabBarIcons[index], selectedImage: tabBarIcons[index])
            viewControllers.append(navigationController)
        }
        return viewControllers
    }
}
