//
//  ArticleDetailController.swift
//  breaking news
//
//  Created by Renat Nazyrov on 15.05.2023.
//

import UIKit
import SafariServices

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
    
    // кнопка на новость
    var openInSafariButton = UIButton(type: .system) {
        didSet {
            openInSafariButton.translatesAutoresizingMaskIntoConstraints = false
            openInSafariButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }
    //  функция нажатия кнопки
    @objc private func SafariButtonPressed() {
        let vc = SFSafariViewController(url: URL(string: urlLabelText)!)
        present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // кнопка
      openInSafariButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50) // задаём фрейм кнопки
        openInSafariButton.backgroundColor = .systemBlue // фон кнопки
        openInSafariButton.setTitleColor(.white, for: .normal) // цвет текста кнопки
        openInSafariButton.setTitle("Full Story", for: .normal) // текст на кнопке
        openInSafariButton.addTarget(self, action: #selector(SafariButtonPressed), for: .touchUpInside) // добавляем действие при нажатии кнопки
        
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
        view.addSubview(openInSafariButton)
        
        titleLabel.anchor(top: imageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        dateLabel.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        contentLabel.anchor(top: dateLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        sourceLabel.anchor(top: contentLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        openInSafariButton.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor).isActive = true
        openInSafariButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        openInSafariButton.anchor(top: sourceLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 5, left: 20, bottom: 0, right: 20))
        
    }
}
