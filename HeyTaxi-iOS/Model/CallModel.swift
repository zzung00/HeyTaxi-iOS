//
//  CallModel.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/13.
//

import Foundation

struct CallModel: Codable {
    var src: LocationModel
    var dst: LocationModel
    
    init(src: LocationModel, dst: LocationModel) {
        self.src = src
        self.dst = dst
    }
}
