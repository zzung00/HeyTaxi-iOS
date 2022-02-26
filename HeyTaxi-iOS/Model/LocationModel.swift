//
//  LocationModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/02/26.
//

import Foundation

struct LocationModel: Codable {
    let latitude: Double
    let longtitude: Double
    
    init(latitude: Double, longtitude: Double) {
        self.latitude = latitude
        self.longtitude = longtitude
    }
}
