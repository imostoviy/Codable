//
//  CellsTableViewCell.swift
//  AwesomeCodableProject
//
//  Created by Мостовий Ігор on 09.01.19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit

class CellsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBOutlet weak var nameOfCcyLabel: UILabel!
    @IBOutlet weak var valueOfBuyLabel: UILabel!
    @IBOutlet weak var valueOfSaleLabel: UILabel!
    static let reuseIdentifyer: String = "Cell"
}
