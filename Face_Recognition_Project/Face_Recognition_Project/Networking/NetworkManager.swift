//
//  NetworkManager.swift
//  Face_Recognition_Project
//
//  Created by Kevin Solano Jiménez on 1/20/21.
//  Copyright © 2021 Kevin Solano Jimenez. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let endpointURL: URL = URL(string: "http://research.blackxells.com:7000")!
    private let boundary = UUID().uuidString
    private let imageParamName: String = "file"
    private let imageName: String = "imageFromIOS.jpg"
    
    
    private init() {}
    
    private func getData(image: UIImage) -> Data {
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(imageParamName)\"; filename=\"\(imageName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        data.append(image.jpegData(compressionQuality: 1)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        return data
    }
    
    func uploadImage(image: UIImage, completion: @escaping (Result<Int, Error>) -> Void) {
        let finalURL = endpointURL.appendingPathComponent("/add")
        var requestURL = URLRequest(url:finalURL)
        requestURL.httpMethod = "POST"
        requestURL.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let data = getData(image: image)
        URLSession.shared.uploadTask(with: requestURL, from: data) { (responseData, httpResponse, error) in
            if let error = error {
                print("Error uploading image -- \(error.localizedDescription)")
            } else {
                guard let response = httpResponse as? HTTPURLResponse else { return }
                print(response.statusCode)
                if (200..<300).contains(response.statusCode) {
                    completion(.success(200))
                } else {
                    completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: nil)))
                }
            }
        }.resume()
    }
    
    func detectImage(image: UIImage, completion: @escaping (Result<Results, Error>) -> Void) {
        let finalURL = endpointURL.appendingPathComponent("/detect")
        var requestURL = URLRequest(url:finalURL)
        requestURL.httpMethod = "POST"
        requestURL.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let data = getData(image: image)
        URLSession.shared.uploadTask(with: requestURL, from: data) { (responseData, httpResponse, error) in
            if let error = error {
                print("Error uploading image -- \(error.localizedDescription)")
            } else {
                guard let response = httpResponse as? HTTPURLResponse else { return }
                if (200..<300).contains(response.statusCode) {
                    let information = try? JSONDecoder().decode(Results.self, from: responseData!)
                    completion(.success(information!))
                } else {
                    completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: nil)))
                }
            }
        }.resume()
    }
}
