//
//  UIKitActivityIndicatorView.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/27/25.
//

import UIKit

extension UIActivityIndicatorView {
    static func spinner() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }
}
