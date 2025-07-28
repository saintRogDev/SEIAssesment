//
//  SimpleBannerView.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/25/25.
//

import Foundation
import UIKit

class SimpleBannerView: UIView {
    //MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Setup
    func setup() {
        clipsToBounds = true
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            bottomAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 16)
        ])
    }
    
    //MARK: - Configure
    func configure(title: String?,
                   subtitle: String?,
                   backgroundColor: UIColor = .red) {
        self.titleLabel.text = title
        self.subTitleLabel.text = subtitle
        self.backgroundColor = backgroundColor
        setNeedsLayout()
    }
}
