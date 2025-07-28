//
//  NewsItemList.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

import SwiftUI

struct NewsSectionView: View {
    @StateObject var viewModel: NewsSectionViewModel
    
    init(viewModel: NewsSectionViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        DashboardSection(title: "News & Updates") {
            switch viewModel.status {
            case .empty:
                Text("No Updates")
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .success(let news):
                contentView(newsItems: news)
            case .failure(let errorMessage):
                Text(errorMessage)
            }
        }
        .task {
            await viewModel.fetchNews()
        }
    }
    
    private func contentView(newsItems: [News]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(newsItems) { news in
                    NewsItemCardView(newsItem: news)
                }
            }
            .padding(.leading)
        }
    }
}
#Preview {
    NewsSectionView(viewModel: NewsSectionViewModel(service: MockNewsService()))
}
