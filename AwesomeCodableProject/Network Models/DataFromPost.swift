//
//  DataFromPost.swift
//  AwesomeCodableProject
//
//  Created by Мостовий Ігор on 1/16/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import Foundation

struct DataFromPost: Decodable {
    let data: Data
    let meta: Meta
}

struct Data: Decodable {
    let id: String
}

struct Meta: Decodable {
    let status: Int
    let msg: String
}
