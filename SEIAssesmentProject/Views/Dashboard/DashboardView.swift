//
//  DashboardView.swift
//  SEIAssesmentProject
//
//  Created by Roger Jones Work  on 7/28/25.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10 ) {
                DashboardHeaderView(imageSource: viewModel.avatarSource,
                                    name: viewModel.currentUserName)
                DegreeProgressView(viewModel: viewModel.degreeProgressViewModel)
                CoursesSectionView(viewModel: viewModel.courseSectionViewModel)
                VStack {
                    StudentResourcesSection()
                        .padding()
                    
                    NewsSectionView(viewModel: viewModel.newsSectionViewModel)
                }
                .background(Color(.systemBackground))
            }
        }
        .background(Color.secondary.opacity(0.05))
        .task {
            await viewModel.loadUser()
        }
    }
}

#Preview {
    DashboardView(viewModel: DashboardViewModel(navigationHandler: NavigationHandler(),
                                                userService: MockUserService()))
}
