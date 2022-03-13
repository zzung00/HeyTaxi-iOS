//
//  ErrorModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/13.
//

import Foundation

struct ErrorModel: Codable {
    var message: String
    
    init(message: String) {
        self.message = message
    }
}
