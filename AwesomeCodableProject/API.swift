//
//  File.swift
//  AwesomeCodableProject
//
//  Created by Мостовий Ігор on 09.01.19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import Foundation

class Getdata {
    
    // MARK: singleton
    
    static let shared = Getdata()
    
    //MARK: Private properties
    
    private let session = URLSession(configuration: .default)
    private var task: URLSessionTask?
    private let urlString: String =  "https://api.privatbank.ua/p24api/infrastructure?json&atm&address="
    
    //MARK: Geting data and parsing JSON
    
    //getting data for currensy
    func getData(completion: @escaping (([Ccy]) -> ())) {
        task?.cancel()
        guard let url = URL(string: "https://api.privatbank.ua/p24api/pubinfo?exchange&json&coursid=11") else { return }
        task = session.dataTask(with: url) {(data, _, _) in
            guard let data = data else { return }
            do {
                let ccy = try JSONDecoder().decode([Ccy].self, from: data)
                completion(ccy)
            } catch {}
        }
        task?.resume()
    }
    
    //getting data for ATM's
    func getAtms(city: String?, complection: @escaping ((ATM) -> ())) {
        task?.cancel()
        guard var urlComponents = URLComponents(string: urlString) else {
            fatalError("Incorrect URL")
        }
        urlComponents.queryItems = [.init(name: "json", value: nil),
                                    .init(name: "atm", value: nil),
                                    .init(name: "address", value: ""),
                                    .init(name: "city", value: city)]
        var temp: String = urlComponents.url!.absoluteString
        task = session.dataTask(with: urlComponents.url!, completionHandler: { (data, _, _) in
            guard let data = data else { return }
            do {
                let atms = try JSONDecoder().decode(ATM.self, from: data)
                defer {DispatchQueue.main.async {
                    complection(atms)
                    }}
                //defer {self.task = nil}
            } catch {}
        })
        task?.resume()
    }
}
