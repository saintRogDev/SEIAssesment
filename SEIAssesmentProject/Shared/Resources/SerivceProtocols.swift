//
//  Protocols.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/25/25.
//

protocol UserServiceProtocol {
    func fetchUser() async throws -> User?
}

protocol CourseServiceProtocol {
    func fetchCourses(for userId: String) async throws -> [Course]?
}

protocol NewsServiceProtocol {
    func fetchNews(for userId: String) async throws -> [News]?
}

protocol DegreeProgramServiceProtocol {
    func fetchDegreeProgress(for userId: String) async throws -> DegreeProgress?
}

protocol CourseMenuServiceProtocol {
    func fetchCourseMenu(for userId: String, courseId: String) async throws -> CourseMenu?
}

protocol QuizDetailsServiceProtocol {
    func fetchQuizDetails(for userId: String, quizId: String) async throws -> QuizDetails?
}
