//
//  CityTableViewCell.swift
//  ios-nunojfg
//
//  Created by Nuno Gonçalves on 09/06/2019.
//  Copyright © 2019 Nuno Gonçalves. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell, BaseViewCellProtocol {

    @IBOutlet var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = SharedConstants.Color.backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ viewModel: CityViewModel) {
        nameLabel.text = viewModel.values.name + ", " + viewModel.values.country
    }
}
