//
//  EmptyCarModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/02/26.
//

import Foundation

struct EmptyCarModel: Codable {
    let taxi: TaxiModel?
    let location: LocationModel
    let timestamp: String
    
    init(taxi: TaxiModel?, location: LocationModel, timestamp: String) {
        self.taxi = taxi
        self.location = location
        self.timestamp = timestamp
    }
}
