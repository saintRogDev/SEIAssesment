//
//  CoursesSectionView.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

import SwiftUI

struct CoursesSectionView: View {
    
    @StateObject var viewModel: CoursesSectionViewModel
    
    init (viewModel: CoursesSectionViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        DashboardSection(title: viewModel.title) {
            switch viewModel.status {
            case .idle:
                idleContent()
            case .loading:
                loadingContent()
            case .empty:
                emptyContent()
            case .success(let courses):
                successContent(courses)
            case .failure(let errorString):
                failureContent(errorString)
            }
        }
        .task {
            await viewModel.fetchCourses()
        }
    }
    
    func idleContent() -> some View {
        EmptyView()
    }
    
    func loadingContent() -> some View  {
        ProgressView()
    }
    
    func emptyContent() -> some View  {
        errorView("No courses found")
    }
    
    func failureContent(_ error: String) -> some View {
        errorView(error)
    }
    
    func successContent(_ courses: [Course]) -> some View  {
        coursesContainer(courses)
    }
    
    @ViewBuilder
    private func coursesContainer(_ courses: [Course]) -> some View {
        HorizontalScrollView(spacing: 8, items: courses) { course in
            CourseCardView(course: course) {
                viewModel.selected(course)
            }
        }
    }
    
    @ViewBuilder
    private func errorView(_ errorText: String) -> some View {
        Text(errorText)
            .font(.headline)
            .padding()
    }
    
}

#Preview {
    CoursesSectionView(viewModel:  CoursesSectionViewModel(userId: "",
                                                           navigationHandler: NavigationHandler(),
                                                           service: MockCourseService()))
}
