//
//  HeyTaxiService.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/02/24.
//

import Foundation
import Alamofire
import Combine

struct VerifyResponse: Codable {
    let success: Bool
    let message: String
    let token: String?
}

struct UserResponse: Codable {
    let success: Bool
    let message: String
    let user: UserModel
}

struct TaxiResponse: Codable {
    let success: Bool
    let message: String
    let taxi: TaxiModel
}

