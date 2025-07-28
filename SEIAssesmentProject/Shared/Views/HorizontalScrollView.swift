//
//  HorizontalScrollView.swift
//  SEIAssesmentProject
//
//  Created by Roger Jones Work  on 7/28/25.
//

import SwiftUI

struct HorizontalScrollView<Item: Identifiable, ItemView: View>: View {
    let spacing: CGFloat
    let items: [Item]
    let itemView: (Item) -> ItemView
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing) {
                ForEach(items) { item in
                    itemView(item)
                }
            }
            .padding(.leading)
        }
    }
}

#Preview {
    HorizontalScrollView(spacing: 5.0,
                         items: MockData.courses) { course in
        Text(course.courseTitle)
            .font(.caption)
            .foregroundColor(.secondary)
    }
}
