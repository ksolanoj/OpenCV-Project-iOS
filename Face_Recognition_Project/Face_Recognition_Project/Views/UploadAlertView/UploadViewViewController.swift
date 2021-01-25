//
//  UploadViewViewController.swift
//  Face_Recognition_Project
//
//  Created by Kevin Solano Jiménez on 1/20/21.
//  Copyright © 2021 Kevin Solano Jimenez. All rights reserved.
//

import UIKit

class UploadViewViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension UploadViewViewController {
    private func setUpView() {
        viewContainer.layer.cornerRadius = 25.0
        viewContainer.layer.borderWidth = 2.5
        viewContainer.layer.borderColor = UIColor.black.cgColor
    }
}
