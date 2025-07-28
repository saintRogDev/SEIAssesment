//
//  QuizDetailsViewModel.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/27/25.
//

import Combine
import Foundation

struct QuizDetailsViewData {
    private let quiz: QuizDetails
    
    init(quiz: QuizDetails) {
        self.quiz = quiz
    }
    
    var quizTitle: String {
        quiz.quizTitle
    }
    
    var dueDate: String? {
        quiz.dueDate?.description ?? "No Due Date"
    }
    
    var submissionType: String  {
        quiz.submissionType
    }
    
    var settings: QuizSettings? {
        quiz.quizSettings
    }
    
    var details: String {
        quiz.quizDetails
    }
    
    static func emptyViewData() -> Self {
        .init(quiz: QuizDetails(courseTitle: "", sectionTitle: "", quizTitle: "", quizAvailable: false, points: 0, totalPoints: 0, submitted: false, dueDate: nil, submissionType: "", quizSettings: QuizSettings(questions: 0, timeLimitMin: 0, allowedAttempts: 0 ), quizDetails: ""))
    }
}

class QuizDetailsViewModel: ObservableObject {
    typealias RequiredData = (userId: String, quizId: String)
    static let defaultNavigationTitle = NSLocalizedString("Quiz Details", comment: "")
    
    private let service: QuizDetailsServiceProtocol
    private let data: RequiredData
    @Published var status: Loadable<QuizDetails> = .idle
    
    init(service: QuizDetailsServiceProtocol, requiredData: RequiredData) {
        self.service = service
        self.data = requiredData
    }
    
    var navigationTitle: String {
        return "Quiz Details"
    }
    
    var navigationSubtitle: String {
        return "\(quiz?.courseTitle ?? "") \(quiz?.sectionTitle ?? "")"
    }
    
    func fetchQuizDetails() async throws {
        status = .loading
        do {
            let quizDetails = try await service.fetchQuizDetails(for: data.userId,
                                                                 quizId: data.quizId)
            handleSuccess(quizDetails)
        } catch {
            handleError(error.localizedDescription)
        }
    }
    
    func makeViewData(for quizDetails: QuizDetails) -> QuizDetailsViewData {
        return .init(quiz: quizDetails)
    }
    
    private func handleSuccess(_ quizDetails: QuizDetails?) {
        guard let quizDetails else {
            self.status = .empty
            return
        }
        self.status = .success(quizDetails)
    }
    
    private func handleError(_ message: String) {
        self.status = .failure(message)
    }
    
    private var quiz: QuizDetails? {
        if case .success(let quiz) = status {
            return quiz
        }
        return nil
    }
}
