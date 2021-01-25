//
//  DataUpload.swift
//  Face_Recognition_Project
//
//  Created by Kevin Solano Jiménez on 1/19/21.
//  Copyright © 2021 Kevin Solano Jimenez. All rights reserved.
//

import Foundation


struct Results: Codable {
    var id: String
    var probabilitie: Double
    var resource: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case probabilitie = "distance"
        case resource
    }
}
