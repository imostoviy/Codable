//
//  DataFromID.swift
//  AwesomeCodableProject
//
//  Created by Мостовий Ігор on 1/16/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import Foundation

struct DataFromID: Decodable {
//    let data: Images
//
//}
//
//struct Images: Decodable {
//    let fixed_width: Fixed_width
//}
//struct Fixed_width: Decodable {
//    let mp4: String
//}
    //    let url: String
    //
    //    enum CodingKeys: String, CodingKey {
    //        case url = "data.images.fixed_width.mp4"
    //    }

    let data: Data
    
    struct Data: Decodable {
        let url: String
    }
}


