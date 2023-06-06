//
//  ClickCountModel.swift
//  breaking news
//
//  Created by Renat Nazyrov on 06.06.2023.
//

import Foundation

class NewsModel {
    var title: String
    var clickCounts: [String: Int] = [:]

    init(title: String) {
        self.title = title
    }
}
