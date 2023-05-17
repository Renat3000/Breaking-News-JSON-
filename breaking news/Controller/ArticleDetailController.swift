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
    
    var titleLabelText: String! {
        didSet {
            print("here's my title text:", titleLabelText!)
        }
    }
    
    var contentLabelText: String! {
        didSet {
            print("here's my content text:", contentLabelText!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        titleLabel.text = titleLabelText
        contentLabel.text = contentLabelText
        
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        
        titleLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 100, left: 20, bottom: 0, right: 20))
        contentLabel.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        
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
