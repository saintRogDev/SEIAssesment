//
//  QuizDetailsViewController.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/27/25.
//

import Combine
import UIKit
import SwiftUICore

class QuizDetailsViewController: UIViewController {
    private var viewModel: QuizDetailsViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    private var detailsCard: QuizDetailsCardView = {
        let cardView = QuizDetailsCardView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()
    private let activityIndicator = UIActivityIndicatorView.spinner()
    
    init(viewModel: QuizDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        bindViewModel()
        setupNavigation()
        setupLayout()
        Task {
            try await viewModel.fetchQuizDetails()
        }
    }
    
    //    MARK: Private
    private func bindViewModel() {
        viewModel.$status
            .receive(on: RunLoop.main)
            .sink { [weak self] status in
                guard let self else { return }
                handle(status)
            }
            .store(in: &cancellables)
    }
    
    private func setupNavigation() {
        self.navigationItem.setTitle(viewModel.navigationTitle,
                                     subtitle: viewModel.navigationSubtitle)
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(detailsCard)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            detailsCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            detailsCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailsCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
            
        ])
    }
    
    private func handle(_ status: Loadable<QuizDetails>) {
        switch status {
        case .loading:
            self.activityIndicator.startAnimating()
        case .success(let quizDetails):
            successState(quizDetails: quizDetails)
        case .failure(let error):
            errorState(error)
        case .empty:
            emptyState()
        case .idle:
            idleState()
        }
    }
    
    private func startSpinner() {
        self.activityIndicator.startAnimating()
    }
    
    private func stopSpinner() {
        self.activityIndicator.stopAnimating()
    }
    
    private func idleState() {
        self.activityIndicator.startAnimating()
        Task {
            try await viewModel.fetchQuizDetails()
        }
    }
    
    private func errorState(_ error: String) {
        self.activityIndicator.stopAnimating()
    }
    
    private func successState(quizDetails: QuizDetails) {
        setupContent(with: viewModel.makeViewData(for: quizDetails))
    }
    
    private func emptyState() {
        self.activityIndicator.stopAnimating()
    }
    
    private func setupContent(with viewData: QuizDetailsViewData) {
        titleLabel.text = viewData.quizTitle
        detailsCard.configure(with: viewData)
        
    }
    
    //MARK: Actions
    @objc
    private func handleBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
