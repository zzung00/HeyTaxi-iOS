//
//  VerifiedViewModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/07.
//

import Foundation

class VerifiedViewModel: ObservableObject {
    @Published var success: Bool = false
    @Published var message: String = ""
    @Published var token: String? = ""
    
    func verify(phone: String, clientSecret: String, code: String) {
        HeyTaxiService.shared.verify(phone: phone, clientSecret: clientSecret, code: code) {
            result in
            self.success = result.success
            self.message = result.message
            self.token = result.token
            
            TokenUtils.create(HeyTaxiService.baseUrl, account: "token", value: self.token!)
        }
    }
}
