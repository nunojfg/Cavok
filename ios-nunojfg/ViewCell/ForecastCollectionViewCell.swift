//
//  ForecastCollectionViewCell.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 24/08/18.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell, BaseViewCellProtocol {
   
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var timeOfDayLabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ viewModel: ForecastViewModel) {
        
        guard let temperature = viewModel.values.summary.temperature else {
            return
        }
        
        self.temperatureLabel.text = MeasurementFormatter().toString(value: temperature)
        self.timeOfDayLabel.text = DateFormatter().timeOfDay(date: viewModel.values.summary.timeOfDay)
        
        self.weatherImageView.image = UIImage(named: viewModel.values.summary.weatherIcon ?? "01d") ?? SharedConstants.Image.defaultWeather
    }
}
