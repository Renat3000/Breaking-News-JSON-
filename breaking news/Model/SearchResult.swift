//
//  SearchResult.swift
//  breaking news
//
//  Created by Renat Nazyrov on 04.04.2023.
//

import Foundation

let defaults = UserDefaults.standard
let clickCountKey = "clickCount "

struct SearchResult: Decodable {
    let articles: [Articles] //переделать на [Article]
    let totalResults: Int
}

struct Articles: Decodable {
    let title: String
    let url: String
    let urlToImage: String?
    let content: String?
    let source: Source
    let publishedAt: String?
    let description: String?
    
    
    var clickCount: Int {
        get {
            let key = clickCountKey + title // Используем уникальный ключ для каждой статьи
            return UserDefaults.standard.integer(forKey: key)
        }
        set {
            let key = clickCountKey + title // Используем уникальный ключ для каждой статьи
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct Source: Decodable {
    let id: String?
    let name: String
}
