//
//  ServiceJSON.swift
//  breaking news
//
//  Created by Renat Nazyrov on 01.06.2023.
//

import Foundation

class ServiceJSON {
    static let shared = ServiceJSON() //singleton
    
    func fetchTopNews(completion: @escaping ([Article])->()) {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=7ecf375a7380407e9a2ba184b5f39a2f"
    
        guard let url = URL(string: urlString) else { return }
        
        // fetch data from internet
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("failed! here's the error:", err)
                return
            }
            
        // if successful
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(TopNewsFetchResult.self, from: data)
//                self.topNewsResults = searchResult.articles //можно так, и потом в closure вывести эти данные
                completion(searchResult.articles)
           
            } catch let jsonErr {
             print("Failed to decode JSON:", jsonErr)
            }
        }.resume() // fire off the request
    }
     func fetchNews(searchTerm: String, completion: @escaping ([SearchArticle])->()) {
        let urlString = "https://newsapi.org/v2/everything?q=\(searchTerm)&sortBy=relevancy&apiKey=7ecf375a7380407e9a2ba184b5f39a2f"

        guard let url = URL(string: urlString) else { return }
        
        // fetch data from internet
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("failed! here's the error:", err)
                return
            }
            
        // if successful
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchJSONResult.self, from: data)
//                self.newsSearchResults = searchResult.articles
                completion(searchResult.articles)
                
            } catch let jsonErr {
             print("Failed to decode JSON:", jsonErr)
            }
        }.resume() // fire off the request
    }
}
