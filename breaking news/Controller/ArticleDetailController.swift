//
//  ArticleDetailController.swift
//  breaking news
//
//  Created by Renat Nazyrov on 15.05.2023.
//

import UIKit

class ArticleDetailController: UIViewController {
    
// эти комментарии ниже писались, когда это был UICollectionViewController 🥸
// 6 строк ниже нужно чтобы приложение не крашилось, когда я открываю в didselectitemat в файле BreakingNewsController вот этот наш текущий контроллер. Была вот эта ошибка: UICollectionView must be initialized with a non-nil layout parameter
//    init() {
//        super.init(collectionViewLayout: UICollectionViewFlowLayout())
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    // дальше все ок, чисто кастомизация и передача данных
    
    var titleLabel = UILabel(text: "Title", font: .boldSystemFont(ofSize: 22), numberOfLines: 0)
    var contentLabel = UILabel(text: "Content of News", font: .boldSystemFont(ofSize: 20), numberOfLines: 0)
    var urlLabel = UILabel(text: "full url", font: .boldSystemFont(ofSize: 20), numberOfLines: 0)
    var imageView = UIImageView()
    var imageViewURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg")! {
        didSet {
            imageView.load(url: imageViewURL)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }
    
    var sourceLabel = UILabel(text: "source", font: .boldSystemFont(ofSize: 20), numberOfLines: 0)
    var dateLabel = UILabel(text: "date", font: .boldSystemFont(ofSize: 20), numberOfLines: 0)
    var titleLabelText: String! {
        didSet {}
    }
    
    var contentLabelText: String! {
        didSet {}
    }
    
    var urlLabelText: String! {
        didSet {}
    }
    
    var sourceLabelText: String! {
        didSet {}
    }
    var dateLabelText: String! {
        didSet {}
    }
    
    //date format
    func formattedDateTime(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        titleLabel.text = titleLabelText
        contentLabel.text = contentLabelText
        urlLabel.text = urlLabelText
        sourceLabel.text = "Source: \(sourceLabelText!)"
        dateLabel.text = formattedDateTime(from: dateLabelText)

        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(contentLabel)
        view.addSubview(sourceLabel)
        view.addSubview(urlLabel)
        
//        imageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 100, left: 20, bottom: 0, right: 20))
        titleLabel.anchor(top: imageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        dateLabel.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        contentLabel.anchor(top: dateLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        sourceLabel.anchor(top: contentLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        urlLabel.anchor(top: sourceLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 5, left: 20, bottom: 0, right: 20))
        
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
////        titleLabel.clipsToBounds = true
//        NSLayoutConstraint.activate([
////            titleLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: bottom, trailing: <#T##NSLayoutXAxisAnchor?#>)
////            titleLabel.topAnchor
//            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            titleLabel.widthAnchor.constraint(equalToConstant: 400),
////            titleLabel.heightAnchor.constraint(equalToConstant: 200)
//        ])
    }
}
