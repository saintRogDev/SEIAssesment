//
//  DashboardHeaderView.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

import SwiftUI

enum DashboardHeaderViewGreeting {
    case morning
    case afternoon
    case evening
    
    var greetingText: String {
        switch self {
        case .morning:
            return "Good morning!"
        case .afternoon:
            return "Good afternoon!"
        case .evening:
            return "Good evening!"
        }
    }
}

struct DashboardHeaderView: View {
    let imageSource: AvatarSource
    let name: String
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Hello, \(name)")
                    .font(.title2)
                    .bold()
                Text(greetingText())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            AvatarView(viewModel: AvatarViewModel(imageSource: imageSource,
                                                  size: 24,
                                                  shape: .circle,
                                                  grayScale: true))
        }
        .padding(.horizontal)
    }
    
    private func greetingText() -> String {
        DashboardHeaderViewGreeting.afternoon.greetingText
    }
    
}

#Preview {
    DashboardHeaderView(imageSource: .image(Image("UserImage")), name: "Abel")
}
