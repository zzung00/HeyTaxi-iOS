//
//  SplashViewModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/02.
//

import Foundation
import Alamofire

class SplashViewModel: ObservableObject {
    @Published var connects: Bool = false
    @Published var showAlert: Bool = false
    
    func serverConnect() {
        HeyTaxiService.shared.serverConnect {
            result in
            self.connects = result
            self.showAlert = result
        }
    }
}
