//
//  ArticleDetailController.swift
//  breaking news
//
//  Created by Renat Nazyrov on 15.05.2023.
//

import UIKit
import SafariServices

class ArticleDetailController: UIViewController {
    
    var titleLabel = UILabel(text: "Title", font: .boldSystemFont(ofSize: 22), numberOfLines: 0)
    var contentLabel = UILabel(text: "Content of News", font: .boldSystemFont(ofSize: 20), numberOfLines: 0)
    var urlLabel = UILabel(text: "full url", font: .boldSystemFont(ofSize: 20), numberOfLines: 0)
    var imageView = UIImageView()
    var imageViewURL = URL(string: K.wikiNoImage)! {
        didSet {
            imageView.loadImage(url: imageViewURL)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30).isActive = true
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }
    
    var sourceLabel = UILabel(text: "source", font: .boldSystemFont(ofSize: 12), numberOfLines: 0)
    var dateLabel = UILabel(text: "date", font: .boldSystemFont(ofSize: 12), numberOfLines: 0)
    var titleLabelText: String = "" // при инициализации контроллера в конструктор передать мапу с этими значниями (как я до этого делал с clickCount)
    var contentLabelText: String = ""
    var urlLabelText: String = ""
    var sourceLabelText: String = ""
    var dateLabelText: String = ""
    
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
    var openInSafariButton = UIButton(type: .roundedRect) {
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
//      фрейм задавать не нужно, ели используем anchor ниже
        openInSafariButton.backgroundColor = .systemBlue // фон кнопки
        openInSafariButton.setTitleColor(.white, for: .normal) // цвет текста кнопки
        openInSafariButton.setTitle("Read Full Story", for: .normal) // текст на кнопке
        openInSafariButton.addTarget(self, action: #selector(SafariButtonPressed), for: .touchUpInside) // добавляем действие при нажатии кнопки
        
        titleLabel.text = titleLabelText
        contentLabel.text = contentLabelText
        urlLabel.text = urlLabelText
        sourceLabel.text = ", \(sourceLabelText)"
        sourceLabel.textColor = .systemGray
        dateLabel.text = formattedDateTime(from: dateLabelText)
        dateLabel.textColor = .systemGray
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(contentLabel)
        view.addSubview(sourceLabel)
        view.addSubview(openInSafariButton)
        
        titleLabel.anchor(top: imageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 20, bottom: 0, right: 0))
        dateLabel.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: sourceLabel.leadingAnchor, padding: .init(top: 8, left: 20, bottom: 0, right: 0))
        sourceLabel.anchor(top: titleLabel.bottomAnchor, leading: dateLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        contentLabel.anchor(top: dateLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 20, bottom: 0, right: 20))
        openInSafariButton.anchor(top: contentLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 200, height: 50))
        openInSafariButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        openInSafariButton.layer.cornerRadius = openInSafariButton.frame.height / 2
        openInSafariButton.layer.masksToBounds = true
    }
}
