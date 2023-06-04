//
//  SearchResultCell.swift
//  breaking news
//
//  Created by Renat Nazyrov on 03.06.2023.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let headlineLabel: UILabel = {
       let label = UILabel()
        label.text = "Breaking News"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let verticalStackView = UIStackView(arrangedSubviews: [
            imageView,
            headlineLabel
        ])
        
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
