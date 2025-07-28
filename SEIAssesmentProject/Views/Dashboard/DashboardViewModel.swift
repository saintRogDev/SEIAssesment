//
//  DashboardViewModel.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

import Combine
import Foundation
import SwiftUICore

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var avatarSource: AvatarSource = .image(.init(systemName: "person.circle"))
    @Published var status: Loadable<User> = .idle
    @Published var courseSectionViewModel: CoursesSectionViewModel!
    @Published var degreeProgressViewModel: DegreeProgressViewModel!
    @Published var newsSectionViewModel: NewsSectionViewModel!
    
    private let navigationHandler: NavigationHandlerProtocol
    private let userService: UserServiceProtocol
    
    init(navigationHandler: NavigationHandlerProtocol,
         userService: UserServiceProtocol) {
        self.userService = userService
        self.navigationHandler = navigationHandler
        configureViewModels()
    }
    
    func loadUser() async {
        status = .loading
        do {
            if let user = try await userService.fetchUser() {
                avatarSource = .image(Image("UserImage"))
                status = .success(user)
            } else {
                status = .failure("No user found")
            }
        } catch {
            status = .failure(error.localizedDescription)
        }
    }
    
    var userId: String {
        if case .success(let user) = status {
            return user.id.uuidString
        }
        return ""
    }
    
    var currentUserName: String {
        if case .success(let user) = status {
            return user.name
        }
        return ""
    }
    
    private func configureViewModels() {
        self.courseSectionViewModel = .init(userId: userId, navigationHandler: navigationHandler, service: MockCourseService())
        self.degreeProgressViewModel = .init(userId: userId, service: MockDegreeProgramService())
        self.newsSectionViewModel = .init(service: MockNewsService())
    }
}
