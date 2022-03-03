//
//  UIColorExtension.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/03.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

extension Color {
    static let mainGreen = Color(hex: "#64D899")
    static let empty = Color(hex: "FF3333")
    static let on = Color(hex: "0066FF")
    static let off = Color(hex: "0099FF")
}
