//
//  LocationModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/02/26.
//

import Foundation

struct LocationModel: Codable {
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
