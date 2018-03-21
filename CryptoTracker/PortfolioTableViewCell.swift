//
//  PortfolioTableViewCell.swift
//  CryptoTracker
//
//  Created by Bryan Kho on 9/2/18.
//  Copyright © 2018 Maxwell Stein. All rights reserved.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    
    func populateCell(withCurrencyType currencytype: CurrencyType) {
        currencyName.text = currencytype.name
        currencyImage.image = currencytype.image
    }
    
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 */

}
