//
//  CourseMenuViewController.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//


import Combine
import Foundation
import UIKit

class CourseMenuViewController: UIViewController {
    private var viewModel: CourseMenuViewModel
    private var cancellables: Set<AnyCancellable> = []
    private let padding = 16.0
    
    // MARK: - SubViews
    private let redBannerView: SimpleBannerView = {
        let banner = SimpleBannerView()
        banner.translatesAutoresizingMaskIntoConstraints = false
        return banner
    }()
    private let statusCardView: StatusCardView = {
        let statusCard = StatusCardView()
        statusCard.translatesAutoresizingMaskIntoConstraints = false
        return statusCard
    }()
    private let listView: CourseMenuListView = {
        let listView = CourseMenuListView()
        listView.translatesAutoresizingMaskIntoConstraints = false
        return listView
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView.spinner()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    //MARK: - init
    init(viewModel: CourseMenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        self.navigationItem.setTitle("Course Menu", subtitle: nil)
        setupLayout()
        setupBinding()
        Task {
            await viewModel.fetchCourseMenu()
        }
    }
    
    //    MARK: Priavte
    private func setupLayout() {
        view.addSubview(activityIndicator)
        view.addSubview(redBannerView)
        view.addSubview(statusCardView)
        view.addSubview(listView)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            redBannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            redBannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            redBannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            statusCardView.topAnchor.constraint(equalTo: redBannerView.bottomAnchor, constant: padding),
            statusCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            statusCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            listView.topAnchor.constraint(equalTo: statusCardView.bottomAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupBinding() {
        viewModel.$status
            .receive(on: RunLoop.main)
            .sink { [weak self] status in
                guard let self else { return }
                handle(status)
            }
            .store(in: &cancellables)
        
        viewModel.$selectedQuizInfo
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { [weak self] selectedQuizInfo in
                guard let self else { return }
                navigateToQuizDetail(selectedQuizInfo)
            }
            .store(in: &cancellables)
        
        listView.didSelectItem = { [weak self] item in
            guard let self else { return }
            viewModel.itemSelected(item: item)
        }
    }
    
    private func handle(_ status: Loadable<CourseMenu>) {
        switch status {
        case .loading:
            startSpinner()
        case .success(let courseMenu):
            successState(viewModel.makeViewData(for: courseMenu))
        case .failure(let error):
            errorState(error)
        case .empty:
            emptyState()
        case .idle:
            idleState()
        }
    }
    
    private func successState(_ viewData: CourseMenuViewData) {
        stopSpinner()
        redBannerView.configure(title: viewData.bannerTitle,
                                subtitle: viewData.bannerSubtitle)
        
        statusCardView.configure(viewModel: viewData.statusCardVM)
        listView.configure(with: viewData.menuItems)
    }
    
    private func errorState(_ error: String) {
        print(error)
        stopSpinner()
    }
    
    private func emptyState() {
        stopSpinner()
    }
    
    private func idleState() {
        stopSpinner()
    }
    
    private func startSpinner() {
        self.activityIndicator.startAnimating()
    }
    
    private func stopSpinner() {
        self.activityIndicator.stopAnimating()
    }
    
    //    MARK: Actions
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Navigation
extension CourseMenuViewController {
    func navigateToQuizDetail(_ quizData: QuizDetailsViewModel.RequiredData) {
        let quizDetailsViewModel = QuizDetailsViewModel(service: MockQuizDetailsService(),
                                                        requiredData: quizData)
        let quizDetailsViewController = QuizDetailsViewController(viewModel: quizDetailsViewModel)
        self.navigationController?.pushViewController(quizDetailsViewController, animated: true)
    }
}
