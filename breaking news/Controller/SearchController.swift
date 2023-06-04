//
//  NewsController.swift
//  breaking news
//
//  Created by Renat Nazyrov on 02.04.2023.
//

import UIKit

private let reuseIdentifierSearch = "Cell"
class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
fileprivate let searchController = UISearchController(searchResultsController: nil)
        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView.backgroundColor = .white
            collectionView!.register(SearchResultCell.self, forCellWithReuseIdentifier: reuseIdentifierSearch)
            setupSearchBar()
    }
    
    fileprivate func setupSearchBar(){
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
    }
    var timer: Timer?
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
            self.fetchNews(searchTerm: searchText)
        })
    }
    
    fileprivate var searchResults = [SearchArticle]()
    fileprivate func fetchNews(searchTerm: String){
        ServiceJSON.shared.fetchNews(searchTerm: searchTerm) { (articles) in
            self.searchResults = articles
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierSearch, for: indexPath) as! SearchResultCell
        let searchResult = searchResults[indexPath.item]
        cell.headlineLabel.text = searchResult.title
        if let url = URL(string: searchResult.urlToImage ?? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg") {
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
