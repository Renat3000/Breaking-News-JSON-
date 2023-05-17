//
//  SearchResultCell.swift
//  breaking news
//
//  Created by Renat Nazyrov on 03.04.2023.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
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
//        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //норм
//        iv.contentMode = UIView.ContentMode.scaleAspectFit
        iv.contentMode = UIView.ContentMode.scaleAspectFill
//        iv.contentMode = UIView.ContentMode.center
        iv.clipsToBounds = true
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
        
        let labelStackView = UIStackView(arrangedSubviews: [
            viewCountView, headlineLabel
        ])
        
        labelStackView.spacing = 10
//        stackview.alignment = .fill
//        addSubview(labelStackView)
        
        let verticalStackView = UIStackView(arrangedSubviews: [
            imageView,
            labelStackView
        ])
//        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 12
        addSubview(verticalStackView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
