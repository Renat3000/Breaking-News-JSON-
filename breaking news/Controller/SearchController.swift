//
//  NewsController.swift
//  breaking news
//
//  Created by Renat Nazyrov on 02.04.2023.
//

import UIKit

private let reuseIdentifier = "Cell"
class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
fileprivate let searchController = UISearchController(searchResultsController: nil)
        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView.backgroundColor = .systemGreen
            collectionView!.register(SearchResultCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            setupSearchBar()
//            fetchNews()
        }
    fileprivate func setupSearchBar(){
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = true
//        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    var timer: Timer?
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.fetchNews(searchTerm: searchText)
        })
    }
    
    fileprivate var appResults = [Articles]()
    fileprivate func fetchNews(searchTerm: String){
        let urlString = "https://newsapi.org/v2/everything?q=\(searchTerm)&sortBy=popularity&apiKey=7ecf375a7380407e9a2ba184b5f39a2f"
//        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=7ecf375a7380407e9a2ba184b5f39a2f"
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
                self.appResults = searchResult.articles
//                self.appResults.forEach({print($0.title)})
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let jsonErr {
             print("Failed to decode JSON:", jsonErr)
            }
        }.resume() // fire off the request
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchResultCell
        let appResult = appResults[indexPath.item]
        cell.headlineLabel.text = appResult.title
        if let url = URL(string: appResult.urlToImage ?? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg") {
            cell.imageView.load(url: url)
        }
        return cell
    }
    
    //чтобы иницализировать легче
        init() {
            super.init(collectionViewLayout: UICollectionViewFlowLayout())
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
