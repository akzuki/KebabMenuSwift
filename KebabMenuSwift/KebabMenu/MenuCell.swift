//
//  SettingCell.swift
//  KebabMenuSwift
//
//  Created by Hai Phan on 8/18/16.
//  Copyright © 2016 Hai Phan. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(menu: Menu) {
        menuImage.image = UIImage(named: menu.menuImage)
        menuLabel.text = menu.menuLabel
    }
}
