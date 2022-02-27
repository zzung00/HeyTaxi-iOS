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

class HeyTaxiService {
    static let host = "172.30.1.43"
    static let baseUrl = "http://\(host)"
    static let shared =  HeyTaxiService()
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Accept" : "application/json"
    ]
    
    func serverConnect(completion: @escaping (Bool) -> Void) {
        AF.request(HeyTaxiService.baseUrl, method: .get, encoding: JSONEncoding.default).responseJSON {
            response  in
            DispatchQueue.main.async {
                completion(response.response?.statusCode == 200)
            }
        }
    }
}
