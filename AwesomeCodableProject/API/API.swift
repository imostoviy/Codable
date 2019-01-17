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
    private let getRandomGif: String = "https://www.placecage.com/gif/"
    private let urlToBePosted: String = "https://upload.giphy.com/v1/gifs?"
    private let sourceUrlForVideo: String = "https://api.giphy.com/v1/gifs/"
    private let size: [Int] = Array(300...400)
    
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
    
    //MARK: post request
    func postRequest(complection: @escaping ((DataFromPost) -> ())) {
        task?.cancel()
        let gifSize = String(size.randomElement() ?? 300)
        let randomGifUrl: String = getRandomGif + "\(gifSize)/\(gifSize)"
        guard var urlComponents = URLComponents(string: urlToBePosted) else { fatalError("Incorrect url") }
        urlComponents.queryItems = [.init(name: "api_key", value: "lc3aGasGwDbt4ZWhRNQGWsZIbS4dzuBu"),
                                  .init(name: "source_image_url", value: randomGifUrl)]
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            do {
                let dataFromJSON = try JSONDecoder().decode(DataFromPost.self, from: data)
                defer { DispatchQueue.main.async {
                    complection(dataFromJSON)
                    self.task = nil
                    }}
            } catch {}
        })
        task?.resume()
    }
    
    //MARK: Grebing data from id
    func getUrlForGif(strindId: String, complection: @escaping((String?, Error?) -> ())) {
        task?.cancel()
        let urlForVideo = sourceUrlForVideo + strindId + "?"
        guard var urlComponents = URLComponents(string: urlForVideo) else { fatalError("Incorrect url") }
        urlComponents.queryItems = [.init(name: "api_key", value: "lc3aGasGwDbt4ZWhRNQGWsZIbS4dzuBu")]
        var temp: String = urlComponents.url!.absoluteString
        task = session.dataTask(with: urlComponents.url!, completionHandler: { (data, responce, error) in
            if error != nil {
                complection(nil, error)
                return
            }
            guard let data = data else { fatalError("Something went wrong") }
            do {
                let url = try JSONDecoder().decode(DataFromID.self, from: data)
                defer {DispatchQueue.main.async {
                    complection(url.data.images.fixed_width.mp4, nil)
                    }}
            } catch {}
        })
        task?.resume()
    }
    
}


