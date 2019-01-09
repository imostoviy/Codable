//
//  File.swift
//  AwesomeCodableProject
//
//  Created by Мостовий Ігор on 09.01.19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import Foundation

class Getdata {
    
    init() {
        getData()
    }
    
    static let shared = Getdata()
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    var data: [Ccy] = []
    
    func getData() {
        guard let url = URL(string: "https://api.privatbank.ua/p24api/pubinfo?exchange&json&coursid=11") else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {(data, _, _) in
            guard let data = data else { return }
            do {
                let ccy = try JSONDecoder().decode([Ccy].self, from: data)
                self.data = ccy
                return
            } catch {}
        }
        task.resume()
    }
}
