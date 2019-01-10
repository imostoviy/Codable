//
//  ATMs.swift
//  AwesomeCodableProject
//
//  Created by Мостовий Ігор on 10.01.19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import Foundation

//MARK: structure for parsing data from ATMs JSON

struct ATM: Decodable{
    let devices: [device]
}

struct device: Decodable {
    let fullAddressRu: String
    let fullAddressUa: String
    let fullAddressEn: String
}
