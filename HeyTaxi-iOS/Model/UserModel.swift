//
//  UserModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/02/24.
//

import Foundation

struct UserModel: Codable {
    let name: String?
    let username: String?
    
    init(name: String, username: String) {
        self.name = name
        self.username = username
    }
}
