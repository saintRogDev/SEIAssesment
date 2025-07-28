//
//  TaskCardView.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

import SwiftUI

struct CourseCardView: View {
    let course: Course
    let onTap: () -> Void
    
    var body: some View {
        VStack {
            header
            titleAndProgressSection
            engagementFooter
            
        }
        .frame(width: 250)
        .background(Color(.systemBackground))
        .contentShape(RoundedRectangle(cornerRadius: 8))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onTapGesture {
            onTap()
        }
    }
    
    private var header: some View {
        ZStack(alignment: .leading) {
            Color(UIColor.systemGray5)
            HStack(spacing: 3) {
                Text("\(course.daysSinceLastEngament) \(course.daysSinceLastEngament > 1 ? "Days" : "Day")")
                    .font(.caption)
                    .bold()
                Text("since last engagement")
                    .font(.caption)
            }
            .padding()
        }
        .frame(height: 40)
    }
    
    private var titleAndProgressSection: some View {
        HStack(alignment: .top, spacing: 15) {
            VStack(alignment: .leading) {
                Text(course.courseTitle)
                    .font(.headline)
                VStack(alignment: .leading) {
                    pill(highlight: "\(course.overDueTasks)", description: "Overdue")
                    pill(highlight: "\(course.upcomingTasks)", description: "Upcoming Tasks", heavyBorder: true)
                }
                
            }
            ProgressRing(progress: course.progress, total: course.total)
        }
        .padding()
    }
    
    private var engagementFooter: some View {
        VStack(spacing: 0) {
            Divider()
            labelWithCount(text: "Unread Messages", systemImage: "envelope", count: course.unreadMessages)
                .padding()
            Divider()
            labelWithCount(text: "Announcements", systemImage: "megaphone", count: course.unreadMessages)
                .padding()
        }
    }
    
    @ViewBuilder
    private func labelWithCount(text: String, systemImage: String, count: Int?) -> some View {
        HStack {
            Label(text, systemImage: "envelope")
                .font(.footnote)
            Spacer()
            if let count {
                Text("\(count)")
                    .font(.subheadline)
                    .bold()
            }
        }
    }
    
    @ViewBuilder
    private func pill(highlight: String, description: String, heavyBorder: Bool = false) -> some View {
        HStack(spacing: 4) {
            Text(highlight)
                .font(.caption)
                .bold()
            Text(description)
                .lineLimit(1)
                .font(.caption)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(.background)
                .stroke(Color.gray.opacity(heavyBorder ? 1.0 : 0.5), lineWidth: 1)
        )
    }
}


#Preview {
    if let course = MockData.courses.first {
        CourseCardView(course: course, onTap: {})
    } else {
        Text("missing mock data")
    }
}
