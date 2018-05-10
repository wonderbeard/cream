//
//  IceCreamListTableViewCell.swift
//  IceCreamFactory
//
//  Created by Andrew Malyarchuk on 10.05.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import UIKit

class IceCreamListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flavorLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    
    func apply(_ viewModel: IceCreamListItemViewModel) {
        nameLabel.text = viewModel.name
        flavorLabel.text = viewModel.flavor
        tempLabel.text = viewModel.temp
        colorLabel.text = viewModel.color
    }

}
