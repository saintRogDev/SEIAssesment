//
//  CoursesSectionViewModel.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/25/25.
//

import SwiftUI

@MainActor
class CoursesSectionViewModel: ObservableObject {
    @Published var title: String = "My Tasks"
    @Published var status: Loadable<[Course]> = .idle
    
    private let userId: String
    private let navigationHandler: NavigationHandlerProtocol
    private let service: CourseServiceProtocol
    
    
    
    init(userId: String, navigationHandler: NavigationHandlerProtocol, service: CourseServiceProtocol) {
        self.navigationHandler = navigationHandler
        self.service = service
        self.userId = userId
    }
    
    func fetchCourses() async {
        self.status = .loading
        do {
            let courses = try await service.fetchCourses(for: userId)
            handleSuccess(courses)
        } catch {
            handleError(error.localizedDescription)
        }
    }
    
    // MARK: User Actions
    func selected(_ course: Course) {
        navigationHandler.navigateToCourses(selectedCourseInfo: (userId, course.id.uuidString))
    }
    
    // MARK: Private
    private func handleSuccess(_ courses: [Course]?) {
        guard let courses else {
            status = .empty
            return
        }
        status = courses.isEmpty ? .empty : .success(courses)
    }
    
    private func handleError(_ error: String) {
        status = .failure(error)
    }
}
