//
//  ResultsViewController.swift
//  Face_Recognition_Project
//
//  Created by Kevin Solano Jiménez on 1/23/21.
//  Copyright © 2021 Kevin Solano Jimenez. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var selectedImage: UIImageView!
    var result: Results?
    var localImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        fillImagesResult()
    }
}

extension ResultsViewController {
    private func setUpView() {
        viewContainer.layer.cornerRadius = 25.0
        viewContainer.layer.borderWidth = 2.5
        viewContainer.layer.borderColor = UIColor.black.cgColor
    }
    private func fillImagesResult() {
        if let results = result {
            selectedImage.image = localImage
            guard let imageURL = URL(string: results.resource) else { return }
            downloadImage(from: imageURL)
        }
    }
    
    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { (data, httpResponse, error) in
            if let error = error {
                print("Error downloading image -- \(error.localizedDescription)")
            }
            guard let response = httpResponse as? HTTPURLResponse else { return }
            if (200...299).contains(response.statusCode) {
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        self.resultImage.image = image
                    }
                }
            } else {
                print("Bad Request Downloading image")
            }
        }.resume()
    }
}
