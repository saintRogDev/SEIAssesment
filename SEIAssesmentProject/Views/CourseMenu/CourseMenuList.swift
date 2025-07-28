//
//  CourseMenuList.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/26/25.
//

import UIKit

class CourseMenuListView: UIView {
    var menuItems: [[CourseMenuItem]] = []
    var didSelectItem: ((CourseMenuItem) -> Void)?
    
    private let tableView: UITableView =  {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "Profile")
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
        tableView.dataSource = self
        tableView.delegate = self   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with items: [[CourseMenuItem]]) {
        self.menuItems = items
        tableView.reloadData()
    }
    
    //    MARK: Private
    private func setup() {
        addSubview(tableView)        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension CourseMenuListView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        menuItems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < menuItems.count else { return 0 }
        return menuItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = menuItems[indexPath.section][indexPath.row]
        if item.description != nil || item.image != nil {
            let cell: ProfileCell = tableView.dequeueReusableCell(withIdentifier: "Profile", for: indexPath) as! ProfileCell
            let cellConfig = ProfileCell.ProfileData(name: item.title, role: item.description, avatarUrl: item.image)
            cell.configure(with: cellConfig)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = item.title
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectItem?(menuItems[indexPath.section][indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = menuItems[indexPath.section][indexPath.row]
        if item.isProfileItem {
            return 73
        }
        return 56
    }
}
