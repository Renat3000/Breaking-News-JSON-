//
//  SearchResultCell.swift
//  breaking news
//
//  Created by Renat Nazyrov on 03.04.2023.
//

import UIKit

class TopNewsCell: UICollectionViewCell {
    
    var articles: Article?
    var clickCount: Int = 0 {
        didSet {
            // Вы можете выполнить здесь необходимые действия с обновленным значением clickCount
            viewCount.text = "\(clickCount)"
        }
    }
    
    func configure(with article: Article) {
            // Конфигурируйте ячейку с данными из article
            // Например, установите значение clickCount в метку:
        articles = article
        viewCount.text = "\(article.clickCount)"
    }

    let clickIcon: UILabel = {
        let label = UILabel()
        label.text = "👆"
        return label
    }()
    
    let viewCount: UILabel! = {
        let count = UILabel()
        count.text = "0"
        count.numberOfLines = 1
        count.widthAnchor.constraint(equalToConstant: 29).isActive = true
        return count
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
//        iv.backgroundColor = .white
//        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 180).isActive = true
        //норм
//        iv.contentMode = UIView.ContentMode.scaleAspectFit
        iv.contentMode = UIView.ContentMode.scaleAspectFill
//        iv.contentMode = UIView.ContentMode.center
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    let headlineLabel: UILabel = {
       let label = UILabel()
        label.text = "Breaking News"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
//        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let viewCountView = UIStackView(arrangedSubviews: [
            clickIcon, viewCount
        ])
        viewCountView.axis = .vertical
        viewCountView.translatesAutoresizingMaskIntoConstraints = false
        viewCountView.alignment = .center
        addSubview(viewCountView)
        
        let labelStackView = UIStackView(arrangedSubviews: [
            viewCountView, headlineLabel
        ])
        labelStackView.axis = .horizontal
        labelStackView.spacing = 0
        addSubview(labelStackView)
        
        let verticalStackView = UIStackView(arrangedSubviews: [
            imageView,
            labelStackView
        ])
        verticalStackView.axis = .vertical
//        verticalStackView.spacing = 0
        addSubview(verticalStackView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
