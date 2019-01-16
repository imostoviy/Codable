//
//  ATMTableViewCell.swift
//  AwesomeCodableProject
//
//  Created by Мостовий Ігор on 10.01.19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit

class ATMTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static let reuseIdentifyer: String = "ATMCell"
    @IBOutlet weak var AdressUA: UILabel!
    @IBOutlet weak var AdressRu: UILabel!
    @IBOutlet weak var AdressUK: UILabel!
}
