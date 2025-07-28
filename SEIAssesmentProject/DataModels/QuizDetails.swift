//
//  QuizDetails.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/27/25.
//
import Foundation

struct QuizDetails {
    let id = UUID()
    let courseTitle: String
    let sectionTitle: String
    let quizTitle: String
    let quizAvailable: Bool
    let points: Int?
    let totalPoints: Int
    let submitted: Bool
    let dueDate: Date?
    let submissionType: String
    let quizSettings: QuizSettings
    let quizDetails: String
}

struct QuizSettings {
    let questions: Int
    let timeLimitMin: Int
    let allowedAttempts: Int
}
