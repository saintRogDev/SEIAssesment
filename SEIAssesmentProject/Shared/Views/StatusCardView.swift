//
//  UIKitStatusCardView.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/25/25.
//

import Foundation
import UIKit

enum StatusCardTone {
    case positive
    case negative
    case neutral
    
    var highlightColor: UIColor {
        switch self {
        case .positive:
            return .systemGreen
        case .negative:
            return .systemRed
        case .neutral:
            return .systemGray
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .positive:
            return UIImage(systemName: "checkmark.circle.fill")
        case .negative:
            return UIImage(systemName: "xmark")
        case .neutral:
            return UIImage(systemName: "")
        }
    }
}

struct StatusCardViewModel {
    let title: String
    let subtitle: String
    let tone: StatusCardTone
}

class StatusCardView: UIView {
    private var viewModel: StatusCardViewModel?
    
    // MARK: - Subviews
    private let sideRibbon: UIView = {
       let view = UIView()
        return view
    }()
    private let title: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    private let icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.frame.size = CGSize(width: 24, height: 24)
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    // MARK: - Initalizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Setup
    func setup() {
        backgroundColor = .systemBackground
    

        let textStack = UIStackView(arrangedSubviews: [title, subtitle])
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView(arrangedSubviews: [sideRibbon, icon, textStack])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(sideRibbon)
        addSubview(icon)
        addSubview(title)
        addSubview(subtitle)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 95),
            
            sideRibbon.topAnchor.constraint(equalTo: self.topAnchor),
            sideRibbon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sideRibbon.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            sideRibbon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            icon.leadingAnchor.constraint(equalTo: sideRibbon.trailingAnchor, constant: 12),
            
            title.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subtitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }
    
    // MARK: - Configure
    func configure(viewModel: StatusCardViewModel?) {
        self.viewModel = viewModel
        self.sideRibbon.backgroundColor = viewModel?.tone.highlightColor
        self.icon.image = viewModel?.tone.icon
        self.icon.tintColor = viewModel?.tone.highlightColor
        self.title.text = viewModel?.title
        self.subtitle.text = viewModel?.subtitle
        setNeedsDisplay()
    }
}
