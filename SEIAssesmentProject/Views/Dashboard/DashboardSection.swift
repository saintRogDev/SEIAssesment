//
//  DashboardSection.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

import SwiftUI

struct DashboardSection<Content: View>: View {
    private let title: String
    private let content: Content
    
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title3)
                .bold()
                .padding(.horizontal)
            content
        }
    }
}

#Preview {
    DashboardSection(title: "My Tasks", content: {Text("Hello World") })
}
