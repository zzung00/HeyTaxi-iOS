//
//  TaxiModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/02/26.
//

import Foundation

struct TaxiModel: Codable {
    let id: Int
    let name: String
    let carNumber: String
    let driver: UserModel
    var location: LocationModel
    
    init(id: Int, user: UserModel, name: String, carNumber: String, location: LocationModel) {
        self.id = id
        self.driver = user
        self.name = name
        self.carNumber = carNumber
        self.location = location
    }
}

enum TaxiStatus: Codable {
    case empty
    case reservation
    case off
}
