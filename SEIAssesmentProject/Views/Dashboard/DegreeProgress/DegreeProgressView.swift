//
//  DegreeProgressView.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/25/25.
//

import SwiftUI

struct DegreeProgressView: View {
    @StateObject var viewModel: DegreeProgressViewModel
    
    init(viewModel: DegreeProgressViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            switch viewModel.status {
            case .empty:
                Text(viewModel.emptyMessage)
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .success:
                content
            case .failure(let errorMessage):
                Text(errorMessage)
            }
        }
        .task {
            await viewModel.fetchDegreeProgress()
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(viewModel.programTitle)
                .foregroundStyle(.white)
                .font(.subheadline).bold()
            ProgressView(value: viewModel.pointsCompleted,
                         total: viewModel.pointTotal)
            .progressViewStyle(LinearProgressViewStyle(tint: .white))
            Text(viewModel.caption)
                .font(.caption)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black.opacity(0.9))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

#Preview {
    DegreeProgressView(viewModel: DegreeProgressViewModel(userId: ""))
}
