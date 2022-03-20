//
//  UserModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/02/24.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    var name: String?
    let username: String?
    
    init(id: Int, name: String, username: String) {
        self.id = id
        self.name = name
        self.username = username
    }
}
