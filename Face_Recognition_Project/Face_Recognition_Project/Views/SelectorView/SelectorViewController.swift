//
//  SelectorViewController.swift
//  Face_Recognition_Project
//
//  Created by Kevin Solano Jiménez on 1/19/21.
//  Copyright © 2021 Kevin Solano Jimenez. All rights reserved.
//

import UIKit

class SelectorViewController: UIViewController {

    @IBOutlet weak var selectorView: UIView!
    private var selectedImage: UIImage?
    private var imageResult: Results?
    var buttonTapped: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != selectorView {
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectorToResults" {
            guard let resultsVC = segue.destination as? ResultsViewController else { return }
            resultsVC.localImage = selectedImage
            resultsVC.result = imageResult
        }
    }
    
    @IBAction func pressedCameraButton(_ sender: Any) {
        openImagePickerController(camera: true)
    }
    
    @IBAction func pressedLibraryButton(_ sender: Any) {
        openImagePickerController(camera: false)
    }
}

extension SelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            selectedImage = image
            if let imageModified = OpenCVWrapper.applyModifications(image) {
                sendImage(image: imageModified)
            }
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension SelectorViewController {
    private func setUpView() {
        selectorView.layer.cornerRadius = 25.0
        selectorView.layer.borderWidth = 2.5
        selectorView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func openImagePickerController(camera useCamera: Bool){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = useCamera ? .camera : .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func sendImage(image: UIImage) {
        if buttonTapped == "detect" {
            NetworkManager.shared.detectImage(image: image) { (result) in
                switch result {
                case.success(let result):
                    print(result.resource)
                    self.imageResult = result
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "selectorToResults", sender: nil)
                    }
                case .failure(let error):
                    print("Error -- \(error)")
                }
            }
        } else if buttonTapped == "upload" {
            NetworkManager.shared.uploadImage(image: image) { (result) in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "selectorToUploadAlert", sender: nil)
                    }
                case .failure(let error):
                    print("Error -- \(error)")
                }
            }
        }
    }
}
