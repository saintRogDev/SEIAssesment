//
//  CourseDetails.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/26/25.
//

import Foundation

struct CourseMenu {
    let id = UUID()
    let courseTitle: String
    let courseDescription: String
    let alert: CourseMenuAlert?
    let menuItems: [[CourseMenuItem]]
}

struct CourseMenuAlert {
    let id = UUID()
    let title: String
    let description: String
    let status: StatusCardTone
}
struct CourseMenuItem {
    let id = UUID()
    let title: String
    let description: String?
    let image: String?
    
    init(title: String, description: String? = nil, image: String? = nil) {
        self.title = title
        self.description = description
        self.image = image
    }
    
    var isProfileItem: Bool {
        description != nil || image != nil
    }
}
