//
//  NewsController.swift
//  breaking news
//
//  Created by Renat Nazyrov on 02.04.2023.
//

import UIKit

private let reuseIdentifier = "Cell"
//api key 7ecf375a7380407e9a2ba184b5f39a2f
class NewsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    * заголовок,
//    * картинка,
//    * количество просмотров содержимого (переходов на экран деталей новости).

        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView.backgroundColor = .systemGreen
            collectionView!.register(SearchResultCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
    
    
    //чтобы иницализировать легче
        init() {
            super.init(collectionViewLayout: UICollectionViewFlowLayout())
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

