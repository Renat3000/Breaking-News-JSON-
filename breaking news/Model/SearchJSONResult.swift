//
//  SearchJSONResult.swift
//  breaking news
//
//  Created by Renat Nazyrov on 03.06.2023.
//

import Foundation

struct SearchJSONResult: Decodable {
    let articles: [SearchArticle]
    let totalResults: Int
}

struct SearchArticle: Decodable {
    let title: String
    let url: String
    let urlToImage: String?
    let content: String?
    let source: NewsSource
    let publishedAt: String?
    let description: String?
}

struct NewsSource: Decodable {
    let id: String?
    let name: String
}
