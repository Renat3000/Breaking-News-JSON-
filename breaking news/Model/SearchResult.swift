//
//  SearchResult.swift
//  breaking news
//
//  Created by Renat Nazyrov on 04.04.2023.
//

import Foundation

struct SearchResult: Decodable {
    let articles: [Articles]
    let totalResults: Int
}

struct Articles: Decodable {
    let title: String
    let url: String
    let urlToImage: String?
}
