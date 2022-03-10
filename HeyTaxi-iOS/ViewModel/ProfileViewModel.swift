//
//  ProfileViewModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/08.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var success: Bool = false
    @Published var message: String = ""
    @Published var user: UserModel?
    
    func updateMe(user: UserModel) {
        HeyTaxiService.shared.updateMe(user: user) {
            result in
            self.success = result.success
            self.message = result.message
            self.user = result.user
        }
    }
    
    func loadMe(completion: @escaping (UserModel) -> Void) {
        HeyTaxiService.shared.loadMe {
            result in
            if(result.success) {
                self.user = result.user
                completion(result.user)
            }
        }
    }
}
