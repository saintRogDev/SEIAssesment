//
//  LoadableEnum.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/25/25.
//
//  A generic enum for representing async loading states.
//  Useful for managing view model and UI state in a type-safe way.

import SwiftUI

enum Loadable<T> {
    case idle
    case loading
    case empty
    case success(T)
    case failure(String)
}
