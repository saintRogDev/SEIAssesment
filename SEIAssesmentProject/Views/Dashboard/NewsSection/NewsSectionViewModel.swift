//
//  NewsSectionViewModel.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/26/25.
//

import Foundation

@MainActor
class NewsSectionViewModel: ObservableObject {
    @Published var status: Loadable<[News]> = .idle
    
    private let service: NewsServiceProtocol
    init(service: NewsServiceProtocol) {
        self.service = service
    }
    
    func fetchNews() async {
        status = .loading
        do {
            let news = try await service.fetchNews(for: "")
            handleSuccess(news)
        } catch {
            handleFailure(error.localizedDescription)
            
        }
    }
    
    private func handleSuccess(_ news: [News]?) {
        guard let news, news.isEmpty == false else {
            status = .empty
            return
        }
        status = .success(news)
    }
    
    private func handleFailure(_ error: String) {
        status = .failure(error)
    }
}
