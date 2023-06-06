//
//  BreakingNewsController.swift
//  breaking news
//
//  Created by Renat Nazyrov on 08.04.2023.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"
class BreakingNewsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    fileprivate var appResults = [Article]() // перенес 👈🏻 сюда наверх, чтобы было лучше видно, сейчас не только в json это использую
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var selectedArticle = appResults[indexPath.item]
            selectedArticle.clickCount += 1 // Увеличиваем clickCount на 1
//        print(selectedArticle.clickCount) // проверка кликов на вшивость
        
        let controller = ArticleDetailController()
        controller.titleLabelText = selectedArticle.title
        controller.dateLabelText = selectedArticle.publishedAt ?? ""
        controller.contentLabelText = selectedArticle.description ?? ""
        controller.urlLabelText = selectedArticle.url
        controller.sourceLabelText = selectedArticle.source.name
        if let imageUrl = URL(string: selectedArticle.urlToImage ?? K.wikiNoImage) {
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
    
        override func viewDidLoad() {
            super.viewDidLoad()
//            collectionView.backgroundColor = .systemGreen
            collectionView.backgroundColor = .white
            collectionView!.register(TopNewsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            
            view.addSubview(activityIndicatorView)
            activityIndicatorView.fillSuperview()
            fetchJSON()
        }

    fileprivate func fetchJSON(){
        ServiceJSON.shared.fetchTopNews { (articles) in
            self.appResults = articles
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 290)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TopNewsCell
        let article = appResults[indexPath.item]
        if let url = URL(string: article.urlToImage ?? K.wikiNoImage) {
            cell.imageView.load(url: url)
        }
        cell.headlineLabel.text = article.title
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
    
    // MARK: - Model Manupilation Methods
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("error saving context \(error)")
        }
        
        collectionView.reloadData()
    }
    
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//        
//       
//    }
}
