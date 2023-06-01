//
//  ServiceJSON.swift
//  breaking news
//
//  Created by Renat Nazyrov on 01.06.2023.
//

import Foundation

class ServiceJSON {
    static let shared = ServiceJSON() //singleton
    
    //++ сделать отдельный под поиск
    func yourNewsSearch(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        let urlString = "https://newsapi.org/v2/everything?q=\(searchTerm)&sortBy=popularity&apiKey=7ecf375a7380407e9a2ba184b5f39a2f"
//        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    var topNewsResults = [Articles]()
    
    func fetchTopNews(completion: @escaping ([Articles])->()) {
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
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                self.topNewsResults = searchResult.articles
                completion(searchResult.articles)
           
            } catch let jsonErr {
             print("Failed to decode JSON:", jsonErr)
            }
        }.resume() // fire off the request
    }
}
