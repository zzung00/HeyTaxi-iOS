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
    
    init(id: Int, user: UserModel, name: String, carNumber: String) {
        self.id = id
        self.driver = user
        self.name = name
        self.carNumber = carNumber
    }
}
