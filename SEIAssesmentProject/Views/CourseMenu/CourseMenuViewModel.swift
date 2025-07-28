//
//  CourseMenuViewModel.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/26/25.
//

import Foundation
import UIKit

struct CourseMenuViewData {
    let courseMenu: CourseMenu
    
    var bannerTitle: String {
        courseMenu.courseTitle
    }
    
    var bannerSubtitle: String {
        courseMenu.courseDescription
    }
    
    var statusCardVM: StatusCardViewModel? {
        guard let alert = courseMenu.alert else { return nil }
        return StatusCardViewModel(title: alert.title, subtitle: alert.description, tone: alert.status)
    }
    
    var menuItems: [[CourseMenuItem]] {
        courseMenu.menuItems
    }
    
}

class CourseMenuViewModel: ObservableObject {
    typealias RequiredData = (userId: String, courseId: String)
    
    @Published var status: Loadable<CourseMenu> = .idle
    @Published var selectedQuizInfo: QuizDetailsViewModel.RequiredData?
    
    private let service: CourseMenuServiceProtocol
    private let requiredData: RequiredData
    
    init(service: CourseMenuServiceProtocol, selectedCourseInfo: RequiredData) {
        self.service = service
        self.requiredData = selectedCourseInfo
    }
    
    func fetchCourseMenu() async {
        status = .loading
        do {
            let courseMenu = try await service.fetchCourseMenu(for: requiredData.userId,
                                                               courseId: requiredData.courseId)
            handleSuccess(courseMenu)
        } catch {
            handleFailure(error.localizedDescription)
        }
    }
    
    func makeViewData(for courseMenu: CourseMenu) -> CourseMenuViewData {
        .init(courseMenu: courseMenu)
    }
    
    func itemSelected(item: CourseMenuItem) {
        // this would be keyed via indicator not verified by title
        if item.title == MockData.quizCellTitle {
            selectedQuizInfo = (userId: requiredData.userId, item.id.uuidString)
        }
    }
    
    private func handleSuccess(_ courseMenus: CourseMenu?) {
        guard let courseMenus else {
            self.status = .empty
            return
        }
        self.status = .success(courseMenus)
    }
    
    private func handleFailure(_ errorMessage: String) {
        print(errorMessage)
    }
}
