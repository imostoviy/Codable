//
//  PostViewController.swift
//  AwesomeCodableProject
//
//  Created by Мостовий Ігор on 1/16/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit
import AVKit

class PostViewController: UIViewController {

    //MARK: private properties
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    private var downloadingId: String = ""
    private var videoUrl: String = ""
    
    //MARK: IBOutlets
    
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var progressview: UIProgressView!
    
    //MARK: IBActions
    @IBAction func postCatButtonPressed(_ sender: UIButton) {
        progressview.progress = 0
        Getdata.shared.postRequest { (dataFromPost) in
            self.downloadingId = dataFromPost.data.id
            self.getUrl(id: dataFromPost.data.id)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postButton.layer.cornerRadius = 3
        postButton.layer.borderWidth = 1
        progressview.progress = 0
    }
    
    func getUrl(id: String) {
        Getdata.shared.getUrlForGif(strindId: id) { (finalUrl, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.videoUrl = finalUrl! + "/200w.mp4"
            print(self.videoUrl)
            self.downloading()
        }
    }
    func downloading() {
        guard let url = URL(string: videoUrl) else { return }
        //let request = URLRequest(url: url)
        session.downloadTask(with: url).resume()
    }

}

//MARK: Extention URLSEssionDownloadDelegete

extension PostViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let player = AVPlayer(url: location)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true, completion: nil)
        playerViewController.player?.play()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        DispatchQueue.main.async {
            self.progressview.setProgress(Float(totalBytesExpectedToWrite / totalBytesWritten), animated: true)
        }
    }
}
