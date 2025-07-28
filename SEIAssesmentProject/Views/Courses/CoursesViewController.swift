//
//  CoursesViewController.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/27/25.
//

import Combine
import UIKit

class CoursesViewModel: ObservableObject {
    @Published var selectedCourseInfo: CourseMenuViewModel.RequiredData?
    
    init (selectedCourseInfo: CourseMenuViewModel.RequiredData?) {
        self.selectedCourseInfo = selectedCourseInfo
    }
    
    func courseMenuSelected(courseInfo: CourseMenuViewModel.RequiredData? = ("", "")) {
        self.selectedCourseInfo = courseInfo
    }
}

class CoursesViewController: UIViewController {
    let viewModel: CoursesViewModel
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: CoursesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setTitle("Courses", subtitle: nil)
        setupView()
        bindViewModel()
    }
    
    func setupView() {
        let label = UILabel()
        label.text = "This is the Courses View : )"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 27)
        view.addSubview(label)
        
        let button = UIButton(type: .system)
        button.setTitle("View a course menu", for: .normal)
        button.addTarget(self, action: #selector(viewCourseMenu), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
        ])
    }
    
    private func bindViewModel() {
        viewModel.$selectedCourseInfo
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { [weak self] courseMenuData in
                guard let self else { return }
               navigateToCourseMenu(courseMenuData: courseMenuData)
            }
            .store(in: &cancellables)
    }
    
    private func navigateToCourseMenu(courseMenuData: CourseMenuViewModel.RequiredData) {
        let coursemenuViewModel = CourseMenuViewModel(service: MockCourseMenuService(),
                                                      selectedCourseInfo: courseMenuData)
        let viewController = CourseMenuViewController(viewModel: coursemenuViewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
        viewModel.selectedCourseInfo = nil
    }
    
    @objc
    func viewCourseMenu() {
        viewModel.courseMenuSelected()
    }
}
