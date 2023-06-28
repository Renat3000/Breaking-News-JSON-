//
//  SearchResultCell.swift
//  breaking news
//
//  Created by Renat Nazyrov on 03.04.2023.
//

import UIKit

class TopNewsCell: UICollectionViewCell {
    
    var articles: Article?
    var clickCount: Int = 0
    
    func configure(clickCount: Int) {
        viewCount.text = "\(clickCount)"
    }
    
    let clickIcon: UILabel = {
        let label = UILabel()
        label.text = "👆"
        label.textAlignment = .center
        return label
    }()
    
    let viewCount: UILabel! = {
        let count = UILabel()
        count.text = "0"
        count.numberOfLines = 1
        count.textAlignment = .center
        return count
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    let headlineLabel: UILabel = {
       let label = UILabel()
        label.text = "Breaking News"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
//        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(clickIcon)
        addSubview(viewCount)
        addSubview(imageView)
        addSubview(headlineLabel)
        
        clickIcon.translatesAutoresizingMaskIntoConstraints = false
        viewCount.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        clickIcon.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        clickIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        clickIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        clickIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        viewCount.topAnchor.constraint(equalTo: clickIcon.bottomAnchor).isActive = true
        viewCount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        viewCount.heightAnchor.constraint(equalToConstant: 35).isActive = true
        viewCount.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        headlineLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        headlineLabel.leadingAnchor.constraint(equalTo: clickIcon.trailingAnchor, constant: 10).isActive = true
        headlineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        headlineLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true

//      the size of the cell is in sizeForItemAt method of BreakingNewsController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
