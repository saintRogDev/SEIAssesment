//
//  MainTabView.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

import Combine
import UIKit
import SwiftUI

enum Tab: Int {
    case home = 0
    case courses = 1
    case support =  2
    case notifications = 3
}

class MainTabBarController: UITabBarController {
    private var cancellables: Set<AnyCancellable> = []
    private let navigationHandler: NavigationHandler
    private var coursesViewModel: CoursesViewModel!
    
    //MARK: - init
    init(handler: NavigationHandler) {
        self.navigationHandler = handler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupControllers()
        bind()
    }
    
    //MARK: - Setup
    func setupControllers() {
        let dashboardViewModel = DashboardViewModel(navigationHandler: navigationHandler,
                                                    userService: MockUserService())
        let home = UIHostingController(rootView: DashboardView(viewModel: dashboardViewModel))
        home.tabBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(named: "tabIconHome"),
                                       tag: Tab.home.rawValue)

        self.coursesViewModel = CoursesViewModel(selectedCourseInfo: navigationHandler.selectedCourseInfo)
        let courses = CoursesViewController(viewModel: coursesViewModel)
        courses.tabBarItem = UITabBarItem(title: "Courses", image: UIImage(named: "tabIconCourses"), tag: Tab.courses.rawValue)
        
        let support = UIHostingController(
            rootView: Text("Support Screen")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground)))
        support.tabBarItem = UITabBarItem(title: "Support", image: UIImage(named: "tabIconSupport"), tag: Tab.support.rawValue)
        
        let notifications = UIHostingController(
            rootView:Text("Notifications View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground)))
        notifications.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(named: "tabIconNotifications"), tag: Tab.notifications.rawValue)
        
        viewControllers =
        [
            home,
            UINavigationController(rootViewController: courses),
            support,
            notifications
        ]
    }
    
    func bind () {
        navigationHandler.$selectedTab
            .receive(on: RunLoop.main)
            .sink { [weak self] newTab in
                guard let self else { return }
                if newTab == .courses {
                    coursesViewModel.selectedCourseInfo = self.navigationHandler.selectedCourseInfo
                }
                self.selectedIndex = newTab.rawValue
            }
            .store(in: &cancellables)
    }
}
