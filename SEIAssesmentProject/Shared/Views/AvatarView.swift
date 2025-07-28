//
//  Avatar.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//

import SwiftUI

enum AvatarShape {
    case circle
    case square
}

enum AvatarSource {
    case url(URL)
    case image(Image)
}

struct AvatarViewModel {
    let imageSource : AvatarSource?
    let size: CGFloat
    let shape: AvatarShape
    let grayScale: Bool
}

struct AvatarView: View {
    private let viewModel: AvatarViewModel
    
    init(viewModel: AvatarViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if let avatarImageSource = viewModel.imageSource {
            switch avatarImageSource {
            case .url(let url):
                avatar(url: url)
            case .image(let image):
                avatar(image: image)
            }
        } else {
            progressView
        }
    }
    
    private var progressView: some View {
        ProgressView()
            .frame(width: viewModel.size,
                   height: viewModel.size)
    }
    
    private func avatar(url: URL) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                avatar(image: image)
            case .failure:
                placeholder
            case .empty:
                progressView
            @unknown default:
                placeholder
            }
            
        }
    }
    
    private func avatar(image: Image) -> some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: viewModel.size,
                   height: viewModel.size)
            .clipShape(clipShape)
            .grayscale(viewModel.grayScale ? 0.9 : 0.0)
    }
    
    private var placeholder: some View {
        Circle()
            .fill(Color.gray)
            .frame(width: viewModel.size,
                   height: viewModel.size)
    }
    
    private var clipShape: some Shape {
        switch viewModel.shape {
        case .circle:
            return AnyShape(Circle())
        case .square:
            return AnyShape(Rectangle())
        }
    }
}

#Preview {
    AvatarView(viewModel: AvatarViewModel(imageSource: .image(Image("LearnerImage")),
                                          size: 25,
                                          shape: .circle,
                                          grayScale: true))
}
