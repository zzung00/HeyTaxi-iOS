//
//  VerifyViewModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/04.
//

import Foundation

class VerifyViewModel: ObservableObject {
    @Published var success: Bool = false
    @Published var message: String = ""
    
    func verifyRequest(phone: String) {
        HeyTaxiService.shared.verifyRequest(phone: phone) {
            result in
            self.success = result.success
            self.message = result.message
        }
    }
}
