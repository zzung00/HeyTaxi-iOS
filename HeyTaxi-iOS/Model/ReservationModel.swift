//
//  ReservationModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/13.
//

import Foundation

struct ReservationModel: Codable {
    var user: UserModel
    var taxi: EmptyCarModel
    var call: CallModel
    
    init(user: UserModel, taxi: EmptyCarModel, call: CallModel) {
        self.user = user
        self.taxi = taxi
        self.call = call
    }
}
