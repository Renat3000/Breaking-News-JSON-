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

//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in //асинхронная загрузка, нооо 👇🏻
//            if let data = try? Data(contentsOf: url) { //синхронная функция Data(contentsOf:), которая может заблокировать главный поток при загрузке данных из сети, что приведет к замораживанию интерфейса
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}

extension UIImageView {
    func loadImage(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self?.image = image
                }
            }
        }.resume()
    }
}
