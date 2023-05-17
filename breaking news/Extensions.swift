//
//  Extensions.swift
//  breaking news
//
//  Created by Renat Nazyrov on 15.05.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1){
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}
