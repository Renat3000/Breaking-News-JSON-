//
//  BreakingNewsController.swift
//  breaking news
//
//  Created by Renat Nazyrov on 08.04.2023.
//

import UIKit

private let reuseIdentifier = "Cell"
class BreakingNewsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var wikiNoImage = "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var selectedArticle = appResults[indexPath.item]
            selectedArticle.clickCount += 1 // Увеличиваем clickCount на 1
//        print(selectedArticle.clickCount) // проверка кликов на вшивость
        
        let controller = ArticleDetailController()
        controller.titleLabelText = selectedArticle.title
        controller.dateLabelText = selectedArticle.publishedAt
        controller.contentLabelText = selectedArticle.description
        controller.urlLabelText = selectedArticle.url
        controller.sourceLabelText = selectedArticle.source.name
        if let imageUrl = URL(string: selectedArticle.urlToImage ?? wikiNoImage) {
        controller.imageViewURL = imageUrl
        }
        collectionView.reloadItems(at: [indexPath]) // Обновляем ячейку для отображения нового значения clickCount
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
        let article = appResults[indexPath.item]
        if let url = URL(string: article.urlToImage ?? wikiNoImage) {
            cell.imageView.load(url: url)
        }
        cell.headlineLabel.text = article.title
//        cell.articles = article
        cell.configure(with: article) // Конфигурируем ячейку с данными статьи
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
