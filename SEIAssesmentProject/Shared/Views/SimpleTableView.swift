//
//  UIKitSimpleTableView.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/25/25.
//

import UIKit
import SwiftUI

class SimpleTableView: UITableViewController {
    struct CellModel {
        let title: String
        let detail: String?
        let image: UIImage?
    }
    
    var data: [CellModel] = []
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StandardCell")
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StandardCell", for: indexPath)
        configureCell(cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { data.count }
    
    // MARK: - Configure
    private func configureCell(_ cell: UITableViewCell,
                                with item: CellModel) {
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.detail
        cell.imageView?.image = item.image
    }
    
    
}
