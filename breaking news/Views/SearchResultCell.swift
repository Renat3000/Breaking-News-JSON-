//
//  SearchResultCell.swift
//  breaking news
//
//  Created by Renat Nazyrov on 03.04.2023.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    let viewCount: UILabel = {
        let count = UILabel()
        count.text = "12314"
        return count
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
//        iv.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        iv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return iv
    }()
    
    let headlineLabel: UILabel = {
       let label = UILabel()
        label.text = "Breaking News"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .blue
        
        let labelStackView = UIStackView(arrangedSubviews: [
            viewCount, headlineLabel
        ])
        labelStackView.spacing = 5
//        stackview.alignment = .fill
        addSubview(labelStackView)
        
        let verticalStackView = UIStackView(arrangedSubviews: [
            labelStackView, imageView
        ])
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 12
//        verticalstackview.alignment = .center
        addSubview(verticalStackView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
