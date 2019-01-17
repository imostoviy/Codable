//
//  DataFromID.swift
//  AwesomeCodableProject
//
//  Created by Мостовий Ігор on 1/16/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import Foundation

struct DataFromID: Decodable {
    //    let url: String
    //
    //    enum CodingKeys: String, CodingKey {
    //        case url = "data.images.fixed_width.mp4"
    //    }

    let data: Data

    struct Data: Decodable {
        let images: Images
    }

    struct Images: Decodable {
        let fixed_width: Fixed
    }

    struct Fixed: Decodable {
        let mp4: String
    }
//    let data: Data
//    struct Data: Decodable {
//        let url: String
//    }
}


