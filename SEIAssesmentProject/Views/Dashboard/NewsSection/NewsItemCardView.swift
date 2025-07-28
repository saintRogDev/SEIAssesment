//
//  NewsItemCardView.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

import SwiftUI

struct NewsItemCardView: View {
    let newsItem: News
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(newsItem.title)
                .font(.subheadline)
                .bold()
            Text(newsItem.description)
                .font(.footnote)
        }
        .padding()
        .background(Color(UIColor.systemGray5))
        .cornerRadius(12)
        .frame(width: 255)
        
    }
}

#Preview {
    if let newsItem = MockData.newsItems.first {
        NewsItemCardView(newsItem: newsItem)
    }
}
