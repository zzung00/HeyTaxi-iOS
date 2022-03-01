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
    
    //서버 연결 확인
    func serverConnect(completion: @escaping (Bool) -> Void) {
        AF.request(HeyTaxiService.baseUrl, method: .get, encoding: JSONEncoding.default).responseJSON {
            response  in
            DispatchQueue.main.async {
                completion(response.response?.statusCode == 200)
            }
        }
    }
    
    //전화번호를 통한 인증 요청 단계
    func verifyRequest(phone: String, completion: @escaping (VerifyResponse) -> Void) {
        let url: String = HeyTaxiService.baseUrl + "/api/verify/request"
        let body: Parameters = [
            "phone": phone
        ]
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default).responseJSON {
            response in
            switch response.result {
            case.success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let verifyResponse = try decoder.decode(VerifyResponse.self, from: data)
                    completion(verifyResponse)
                } catch {}
            default:
                return
            }
        }
    }
    
    //문자로 수신된 인증번호를 통한 인증 확인 단계
    func verify(phone: String, clientSecret: String, code: String, completion: @escaping (VerifyResponse) -> Void) {
        let url: String = HeyTaxiService.baseUrl + "/api/verify/verify"
        let body: Parameters = [
            "phone": phone,
            "clientSecret": clientSecret,
            "code": code
        ]
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default).responseJSON {
            response in
            switch response.result {
            case.success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let verifyResponse = try decoder.decode(VerifyResponse.self, from: data)
                    completion(verifyResponse)
                } catch {}
            default:
                return
            }
        }
    }
}