//
//  QuizDetailsCardView.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/27/25.
//

import UIKit

class QuizDetailsCardView: UIView {
    
    // MARK: - Subviews
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Take Quiz", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.text = "-/50 pts"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()
    
    private let statusBadge: UILabel = {
        let label = UILabel()
        label.text = "Not Submitted"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemBlue
        label.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()

    private var dueDateView: UIStackView {
        return QuizDetailsCardView.labelGroup(title: "Due Date:", value: viewData.dueDate ?? "No Due Date")
    }
    private var submissionTypeView: UIStackView {
        QuizDetailsCardView.labelGroup(title: "Submission Type:", value: viewData.submissionType)
    }
    private var settingsView: UIStackView {
        let settings = viewData.settings ?? .init(questions: 0, timeLimitMin: 0, allowedAttempts: 0)
        return QuizDetailsCardView.labelGroup(title: "Settings:", value: "Questions: \(settings.questions)\nTime Limit: \(settings.timeLimitMin) Minutes\nAllowed Attempts: \(settings.allowedAttempts)")
    }
    private var detailsView: UIStackView {
        QuizDetailsCardView.labelGroup(title: "Details:", value: viewData.details)
    }

    private let viewMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View More ⌄", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private var viewData: QuizDetailsViewData
    // MARK: - init
    init(viewData: QuizDetailsViewData = .emptyViewData()) {
        self.viewData = viewData
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewData: QuizDetailsViewData) {
        self.viewData = viewData
        setupLayout()
    }
    
    // MARK: - Layout
    private func setupLayout() {
        let cardStack = UIStackView(arrangedSubviews: [
            actionButton,
            horizontalStack(pointsLabel, statusBadge),
            divider(),
            dueDateView,
            divider(),
            submissionTypeView,
            divider(),
            settingsView,
            divider(),
            detailsView,
            viewMoreButton
        ])
        cardStack.axis = .vertical
        cardStack.spacing = 20
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        cardStack.backgroundColor = .systemBackground
        cardStack.isLayoutMarginsRelativeArrangement = true
        cardStack.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        cardStack.layer.cornerRadius = 8

        addSubview(cardStack)
        
        NSLayoutConstraint.activate([
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            cardStack.topAnchor.constraint(equalTo: topAnchor),
            cardStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cardStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private static func labelGroup(title: String, value: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textColor = .label
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 14)
        valueLabel.textColor = .secondaryLabel
        valueLabel.numberOfLines = 0
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }
    
    private func divider() -> UIView {
        let divider = UIView()
        divider.backgroundColor = .systemFill
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
        return divider
    }
    
    private func horizontalStack(_ left: UIView, _ right: UIView) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [left, right])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }
}
