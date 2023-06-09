//
//  SearchResult.swift
//  breaking news
//
//  Created by Renat Nazyrov on 04.04.2023.
//

import Foundation


struct TopNewsFetchResult: Decodable {
    let articles: [Article] 
    let totalResults: Int
}

struct Article: Decodable {
    let title: String
    let url: String
    let urlToImage: String?
    let content: String?
    let source: Source
    let publishedAt: String?
    let description: String?
}

struct Source: Decodable {
    let id: String?
    let name: String
}
