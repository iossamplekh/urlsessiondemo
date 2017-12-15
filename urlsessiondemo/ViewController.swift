//
//  ViewController.swift
//  urlsessiondemo
//
//  Created by KSHRD on 12/15/17.
//  Copyright © 2017 KSHRD. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var testProgressView: UIProgressView!
    @IBOutlet weak var testIndecator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1 create url
        let url = URL(string: "https://images5.alphacoders.com/568/568499.jpg")
        //2 create url request
        let urlRequest = URLRequest(url: url!)
        //
        //3 configuration url
        let configuraton = URLSessionConfiguration.default
        let session = URLSession(configuration: configuraton, delegate: self, delegateQueue: nil)
        
        let downloadTask = session.downloadTask(with: urlRequest)
        downloadTask.resume()
        
        self.testIndecator.hidesWhenStopped = true
        self.testIndecator.startAnimating()

    }

    

}
extension ViewController: URLSessionDelegate,URLSessionDownloadDelegate{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let data = try! Data(contentsOf: location)
        
        DispatchQueue.main.async {
            self.testIndecator.stopAnimating()
            self.testProgressView.isHidden = true
            self.imageView.image = UIImage(data:data)
        }
    }
    
  
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        print(#function)
        let process = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        
        DispatchQueue.main.sync {
            self.testProgressView.progress = process
        }
    }
    

}

