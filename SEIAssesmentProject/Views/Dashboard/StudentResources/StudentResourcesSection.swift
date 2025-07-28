//
//  StudentResourcesView.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

import SwiftUI

struct StudentResourcesSection: View {
    let items = [("Campus", "shield"), ("Finances", "creditcard"), ("Academics", "graduationcap"), ("Grades", "star"), ("Library", "book")]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Student Resources")
                    .font(.title3)
                    
                Spacer()
                Text("See more")
                    .font(.caption)
            }

            HStack {
                ForEach(items, id: \.0) { item in
                    VStack {
                        Image(systemName: item.1)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(item.0)
                            .font(.caption2)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

#Preview {
    StudentResourcesSection()
}
