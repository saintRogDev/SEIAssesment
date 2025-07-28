//
//  ProfileCell.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/27/25.
//

import Foundation

import UIKit
import SwiftUI

class ProfileCell: UITableViewCell {
    struct ProfileData {
        let name: String
        let role: String?
        let avatarUrl: String?
        
        var avatarSource: AvatarSource {
            if let url = URL(string: avatarUrl ?? ""),
               UIApplication.shared.canOpenURL(url) {
                return  .url(url)
            } else {
                return .image(Image("LearnerImage"))
            }
        }
    }
    
    func configure(with profile: ProfileData) {
        self.contentConfiguration = UIHostingConfiguration {
            HStack(spacing: 12) {
                AvatarView(viewModel: AvatarViewModel(imageSource: profile.avatarSource,
                                                      size: 35,
                                                      shape: .square,
                                                      grayScale: false))
                VStack(alignment: .leading, spacing: 4) {
                    Text(profile.name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    if let role = profile.role {
                        Text(role)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                    
                }
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
}
