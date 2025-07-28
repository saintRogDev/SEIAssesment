//
//  NewsItem.swift
//  SEIAssesment
//
//  Created by Roger Jones Work  on 7/24/25.
//
import Foundation

struct News: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}
