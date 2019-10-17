//
//  ForecastListTableViewCell.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 19/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import UIKit

class ForecastListTableViewCell: UITableViewCell, BaseViewCellProtocol {
    
    @IBOutlet var collectionView: UICollectionView!
    private var dataSource: ForecastCollectionViewDataSource?
    
    struct Constants {
        static let defaultWeatherImage: UIImage =  UIImage(named: "defaultWeather")!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        dataSource = ForecastCollectionViewDataSource(collectionView: self.collectionView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ viewModel: ForecastListViewModel) {
        
        dataSource?.items = viewModel.values.items
        dataSource?.collectionView?.reloadData()
    }
}
