//
//  MockService.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

import Combine
import Foundation

class MockUserService: UserServiceProtocol {
    var shouldThrow: Bool = false
    var userToReturn: User?
    
    func fetchUser() async throws -> User? {
        try await Task.sleep(for: .seconds(1))
        if shouldThrow {
            throw NSError(domain: "Mock", code: 999, userInfo: [NSLocalizedDescriptionKey : "Mock error"])
        }
        return userToReturn != nil ? userToReturn : MockData.user
    }
}

class MockCourseService: CourseServiceProtocol {
    var errorTest: Bool = false
    
    func fetchCourses(for userId: String) async throws -> [Course]? {
        try await Task.sleep(for: .seconds(1))
        if errorTest {
            throw NSError(domain: "Mock", code: 999, userInfo: [NSLocalizedDescriptionKey : "Mock error"])
        }
        return MockData.courses
    }
}

class MockNewsService: NewsServiceProtocol {
    func fetchNews(for userId: String) async throws -> [News]? {
        try await Task.sleep(for: .seconds(1))
        return MockData.newsItems
    }
}

class MockDegreeProgramService: DegreeProgramServiceProtocol {
    func fetchDegreeProgress(for userId: String) async throws -> DegreeProgress? {
        try await Task.sleep(for: .seconds(1))
        return MockData.degree
    }
}

class MockCourseMenuService: CourseMenuServiceProtocol {
    func fetchCourseMenu(for userId: String, courseId: String) async throws -> CourseMenu? {
        try await Task.sleep(for: .seconds(1))
        return MockData.courseMenu
    }
}

class MockQuizDetailsService: QuizDetailsServiceProtocol {
    func fetchQuizDetails(for userId: String, quizId: String) async throws -> QuizDetails? {
        try await Task.sleep(for: .seconds(1))
        return MockData.quizDetails
    }
}
