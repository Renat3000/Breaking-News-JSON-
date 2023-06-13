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
    let refreshControl = UIRefreshControl() // pull to refresh
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //смотрим из памяти клики и ув на 1
        let selectedArticle = appResults[indexPath.item]
        if let newsArticle = fetchNewsArticle(with: selectedArticle.title) {
            newsArticle.clickCount += 1
            do {
                try context.save() // Сохраняем контекст, чтобы сохранить изменения
            } catch {
                print("Failed to update news article: \(error)")
            }
        }
        
        let controller = ArticleDetailController()
        controller.titleLabelText = selectedArticle.title
        controller.dateLabelText = selectedArticle.publishedAt ?? ""
        controller.contentLabelText = selectedArticle.description ?? ""
        controller.urlLabelText = selectedArticle.url
        controller.sourceLabelText = selectedArticle.source.name
        if let imageUrl = URL(string: selectedArticle.urlToImage ?? K.wikiNoImage) {
            controller.imageViewURL = imageUrl
        }
        
        collectionView.reloadItems(at: [indexPath]) // Обновляем ячейку для отображения нового clickCount
        self.navigationController?.pushViewController(controller, animated: true) // открываем ArticleDetailController()
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView.backgroundColor = .white
            collectionView!.register(TopNewsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            fetchNewsFromCoreData()
            collectionView.refreshControl = refreshControl
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged) //что делаем при рефреше
            
//            view.addSubview(activityIndicatorView) // это и строка ниже - троббер, пока убрал. потому что добабил refreshControl = pull to refresh
//            activityIndicatorView.fillSuperview()
        }

    fileprivate func fetchJSON(){
        ServiceJSON.shared.fetchTopNews { (articles) in
            self.appResults = articles
            for article in articles {
                if let existingArticle = self.fetchNewsArticle(with: article.title) {
                    // Обновить существующий объект "NewsArticle"
                    existingArticle.url = article.url
                    existingArticle.urlToImage = article.urlToImage
                    existingArticle.sourceName = article.source.name
                    // existingArticle.clickCount = article.clickCount
                    existingArticle.content = article.content
                    existingArticle.newsDescription = article.description
                    existingArticle.publishedAt = article.publishedAt
                    existingArticle.title = article.title
                } else {
                    let articleInCoreData = NewsArticle(context: self.context)
                    articleInCoreData.sourceName = article.source.name
                    // articleInCoreData.clickCount = article.clickCount
                    articleInCoreData.content = article.content
                    articleInCoreData.newsDescription = article.description
                    articleInCoreData.publishedAt = article.publishedAt
                    articleInCoreData.title = article.title
                    articleInCoreData.url = article.url
                    articleInCoreData.urlToImage = article.urlToImage
                }
                do {
                    try self.context.save()
                } catch {
                    print("can't save articleInCoreData in CoreData", error)
                }
            }
            DispatchQueue.main.async {
//                self.fetchNewsFromCoreData() //вот тут все крашится
                self.collectionView.reloadData()
                // self.activityIndicatorView.stopAnimating() пока удалил троблер
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
            cell.imageView.loadImage(url: url)
        }
        cell.headlineLabel.text = article.title
        if let newsArticle = fetchNewsArticle(with: article.title) {
            let clicksFromMemory = newsArticle.clickCount // Обновляем атрибут "clickCount"
            cell.configure(clickCount: Int(clicksFromMemory))
        }
        return cell
    }
    
    @objc func refreshData() {
        fetchJSON() // обновляем данные
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl.endRefreshing() // Завершаем обновление
        }
    }
    
    // MARK: - Init
    //чтобы иницализировать легче
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Misk (throbber and trashButton function)
    //анимация загрузки (throbber)
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    //функция trash кнопки
    @objc func trashButtonTapped() {
//        print("Trash button tapped") // Отладочный вывод
        deleteNewsArticles()
    }
    
    
    // MARK: - Model Manupilation Methods
    
    func fetchNewsFromCoreData() {
        let fetchRequest: NSFetchRequest<NewsArticle> = NewsArticle.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            
            // Преобразование объектов NewsArticle в Article
            let articles = results.map { newsArticle in
                return Article(
                    title: newsArticle.title ?? "",
                    url: newsArticle.url ?? "",
                    urlToImage: newsArticle.urlToImage,
                    content: newsArticle.content,
                    source: Source(id: newsArticle.sourceID, name: newsArticle.sourceName ?? ""),
                    publishedAt: newsArticle.publishedAt ?? "",
                    description: newsArticle.newsDescription ?? ""
                )
            }

            appResults = articles // Обновление массива новостей в вашем контроллере
            
            DispatchQueue.main.async {
                self.collectionView.reloadData() // Обновление интерфейса
            }
        } catch let error {
            print("Error fetching news from Core Data: \(error.localizedDescription)")
        }
    }

    func fetchNewsArticle(with title: String) -> NewsArticle? {
        let fetchRequest: NSFetchRequest<NewsArticle> = NewsArticle.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed to fetch news article: \(error)")
            return nil
        }
    }

    func deleteNewsArticles() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NewsArticle> = NewsArticle.fetchRequest()
        
        do {
            let articles = try managedObjectContext.fetch(fetchRequest)
            for article in articles {
                managedObjectContext.delete(article)
            }
            
            try managedObjectContext.save()
            
            // Блок обновления экрана
            self.appResults.removeAll()
            self.collectionView.reloadData()
            
        } catch let error as NSError {
            print("Error deleting news articles: \(error.localizedDescription)")
        }
    }
}
