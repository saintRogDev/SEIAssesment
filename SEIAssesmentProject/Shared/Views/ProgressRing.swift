//
//  ProgressRing.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

import SwiftUI

struct ProgressRing: View {
    let progress: Int
    let total: Int
    let size: CGFloat
    
    init(progress: Int, total: Int, size: CGFloat? = nil) {
        self.progress = progress
        self.total = total
        self.size = size ?? 70
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.05), lineWidth: 11)
                .frame(width: size, height: size)
            
            Circle()
                .trim(from: 0, to: CGFloat((Double(progress) / Double(total))))
                .stroke(Color(UIColor.systemGray5), style:  StrokeStyle(lineWidth: 11, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: size, height: size)
            
            HStack(alignment: .center, spacing: 0){
                Text("\(progress)")
                    .font(.headline)
                Text("/\(total)")
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    ProgressRing(progress: 14, total: 32)
}
