//
//  BreakingNewsController.swift
//  breaking news
//
//  Created by Renat Nazyrov on 08.04.2023.
//

import UIKit

private let reuseIdentifier = "Cell"
class BreakingNewsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var clickCount: Int
    var wikiNoImage = "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"
    func viewCountUpdate() -> Int {
        
        if clickCount == nil {
            clickCount = 1
        } else {
            clickCount += 1
        }
        return clickCount ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let number = viewCountUpdate()
//        print("number is", number)
        clickCount = number
//        print("clickCount is", clickCount)
//        viewCountUpdate()
//        print(number)
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchResultCell
//
//        cell.clicks = number
        
        let article = appResults[indexPath.item]
        let controller = ArticleDetailController()
        controller.titleLabelText = article.title
        controller.dateLabelText = article.publishedAt
        controller.contentLabelText = article.description
        controller.urlLabelText = article.url
        controller.sourceLabelText = article.source.name
        if let imageUrl = URL(string: article.urlToImage ?? wikiNoImage) {
        controller.imageViewURL = imageUrl
        }
        
        collectionView.reloadData()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //анимация загрузки (throbber)
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
//fileprivate let searchController = UISearchController(searchResultsController: nil)
        override func viewDidLoad() {
            super.viewDidLoad()
//            collectionView.backgroundColor = .systemGreen
            collectionView.backgroundColor = .white
            collectionView!.register(SearchResultCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            
            view.addSubview(activityIndicatorView)
            activityIndicatorView.fillSuperview()
            fetchNews()
        }

    fileprivate var appResults = [Articles]()
    fileprivate func fetchNews(){
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
                self.appResults = searchResult.articles
//                self.appResults.forEach({print($0.title)})
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.activityIndicatorView.stopAnimating()
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
        if let url = URL(string: appResult.urlToImage ?? wikiNoImage) {
            cell.imageView.load(url: url)
        }
        cell.headlineLabel.text = appResult.title
        cell.viewCount.text = "\(clickCount)"
//        cell.horizontalController.didSelectHandler
//        self.didSelectHandler = { [weak self] articles in
//            let controller = ArticleDetailController()
//            controller.navigationItem.title = articles.title
////            controller.appId = articles.content
//            self?.navigationController?.pushViewController(controller, animated: true)
//        }
        return cell
    }
    
    //чтобы иницализировать легче
    //        init() {
    //
    //        }
    init(clickCount: Int) {
        self.clickCount = clickCount
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
