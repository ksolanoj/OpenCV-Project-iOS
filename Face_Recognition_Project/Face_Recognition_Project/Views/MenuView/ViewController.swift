//
//  ViewController.swift
//  Face_Recognition_Project
//
//  Created by Kevin Solano Jimenez on 10/14/20.
//  Copyright © 2020 Kevin Solano Jimenez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var detectFaceButton: UIButton!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    private var buttonTapped: String = "nil"

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    @IBAction func detectFaceFunction(_ sender: Any) {
        buttonTapped = "detect"
        performSegue(withIdentifier: "menuToSelect", sender: nil)
        
    }
    @IBAction func uploadPhotoFunction(_ sender: Any) {
        buttonTapped = "upload"
        performSegue(withIdentifier: "menuToSelect", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectVC = segue.destination as? SelectorViewController else { return }
        selectVC.buttonTapped = buttonTapped
    }
}

extension ViewController {
    private func setUpView() {
        detectFaceButton.layer.cornerRadius = 25.0
        detectFaceButton.layer.borderWidth = 0.5
        detectFaceButton.layer.borderColor = UIColor.black.cgColor
        uploadPhotoButton.layer.cornerRadius = 25.0
        uploadPhotoButton.layer.borderWidth = 0.5
        uploadPhotoButton.layer.borderColor = UIColor.black.cgColor
    }
}



