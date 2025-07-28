//
//  DegreeProgressViewModel.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/26/25.
//

import Foundation

@MainActor
class DegreeProgressViewModel: ObservableObject {
    @Published var status: Loadable<DegreeProgress> = .idle
    
    private let service: DegreeProgramServiceProtocol
    private let userId: String
    
    init(userId: String, service: DegreeProgramServiceProtocol = MockDegreeProgramService()) {
        self.service = service
        self.userId = userId
    }
    
    func fetchDegreeProgress() async {
        do {
            self.status = .loading
            if let degreeProgress = try await service.fetchDegreeProgress(for: userId) {
                self.status = .success(degreeProgress)
            } else {
                self.status = .success(DegreeProgress(title: programTitle, pointsCompleted: pointsCompleted, pointsToal: Int(pointTotal)))
            }
        } catch {
            self.status = .failure(error.localizedDescription)
        }
    }
    
    var programTitle: String {
        if case .success(let degree) = status {
            return degree.title
        }
        return ""
    }
    
    var pointsCompleted: CGFloat {
        if case .success(let degree) = status {
            return degree.pointsCompleted
        }
        return 0
    }
    
    var pointTotal: CGFloat {
        if case .success(let degree) = status {
            return CGFloat(degree.pointsToal)
        }
        return 0
    }
    
    var caption: String {
        if case .success = status {
            return "\(pointsCompleted) of \(pointTotal) points completed"
        }
        return ""
    }
    
    var emptyMessage: String {
        "No degree progress data available"
    }
    
}

