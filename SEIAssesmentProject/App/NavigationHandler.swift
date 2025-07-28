//
//  Router.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/25/25.
//

import Foundation

protocol NavigationHandlerProtocol {
    func navigateToHome()
    func navigateToCourses(selectedCourseInfo: CourseMenuViewModel.RequiredData)
    func navigateToSupprt()
    func navigateToNotifications()
    
    var selectedCourseInfo: (userId: String, courseId: String)? { get }
}

class NavigationHandler: ObservableObject, NavigationHandlerProtocol {
    @Published var selectedTab: Tab = .home
    var selectedCourseInfo: CourseMenuViewModel.RequiredData?

    func navigateToHome() {
        selectedTab = .home
    }
    
    func navigateToCourses(selectedCourseInfo: CourseMenuViewModel.RequiredData) {
        selectedTab = .courses
        self.selectedCourseInfo = selectedCourseInfo
    }
    
    func navigateToSupprt() {
        selectedTab = .support
    }
    
    func navigateToNotifications() {
        selectedTab = .notifications
    }
}


extension NavigationHandler {
    static var mock = NavigationHandler()
}
