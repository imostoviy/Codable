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
        return URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }()
    private var downloadingId: String = ""
    private var videoUrl: String = ""
    
    //MARK: IBOutlets
    
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var progressview: UIProgressView!
    
    //MARK: IBActions
    @IBAction func postCatButtonPressed(_ sender: UIButton) {
        progressview.progress = 0
        Getdata.shared.postRequest { (finalURL) in
            if finalURL != nil {
                self.videoUrl = finalURL!
                self.downloading()
            }
        }
    }
    
    //MARL:viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        postButton.layer.cornerRadius = 3
        postButton.layer.borderWidth = 1
        progressview.progress = 0
    }

    func downloading() {
        guard let url = URL(string: videoUrl) else { return }
        session.downloadTask(with: url).resume()
    }

}

//MARK: Extention URLSEssionDownloadDelegete

extension PostViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = documentsDirectoryURL.appendingPathComponent("gif.mp4")
        
        do {
            try FileManager.default.removeItem(at: destinationURL)
            try FileManager.default.moveItem(at: location, to: destinationURL)
        } catch CocoaError.fileNoSuchFile {
            do {
                try FileManager.default.moveItem(at: location, to: destinationURL)
            } catch {
                debugPrint("aborting because of \(error)")
            }
        } catch {
            debugPrint("Aborting saving operation becouse of such reason \(error)")
        }
        
        let player = AVPlayer(url: destinationURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true, completion: nil)
        playerViewController.player?.play()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        DispatchQueue.main.async {
            self.progressview.progress = (Float(totalBytesWritten) / Float(totalBytesExpectedToWrite))
        }
    }
}
