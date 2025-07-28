//
//  Task.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

import Foundation

struct Course: Identifiable {
    let id = UUID()
    let courseTitle: String
    let daysSinceLastEngament: Int
    let overDueTasks: Int
    let upcomingTasks: Int
    let unreadMessages: Int
    let announcements: Int
    let progress: Int
    let total: Int
}
