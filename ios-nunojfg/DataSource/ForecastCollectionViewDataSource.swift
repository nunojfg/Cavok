//
//  ForecastCollectionViewDataSource.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 24/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation
import UIKit

class ForecastCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    internal let collectionView: UICollectionView?
    var items: [ForecastViewModel] = [ForecastViewModel]()
    
    init(collectionView: UICollectionView) {
       
        self.collectionView = collectionView
        super.init()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 90, height: 90)
        flowLayout.scrollDirection = .horizontal
        
        self.collectionView?.collectionViewLayout = flowLayout
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.backgroundColor = SharedConstants.Color.backgroundColor
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.register(UINib(nibName: ForecastCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ForecastCollectionViewCell.reuseIdentifier)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.reuseIdentifier,
                                                       for: indexPath ) as? ForecastCollectionViewCell else {
                                                        return UICollectionViewCell()
        }
        
        let viewModel = self.items[indexPath.row]
        
        cell.configureCell(viewModel)
        
        return cell
    }
    
}

