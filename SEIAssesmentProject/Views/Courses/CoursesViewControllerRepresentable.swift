//
//  UIKitCourseMenu.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/25/25.
//

import SwiftUI

struct CoursesViewControllerRepresentable: UIViewControllerRepresentable {
    let viewModel: CoursesViewModel
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let viewController = CoursesViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // no-op
    }
}
