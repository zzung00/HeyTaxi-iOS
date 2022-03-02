//
//  SplashView.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/02.
//

import SwiftUI

struct SplashView: View {
    @StateObject private var viewModel = SplashViewModel()
    
    var body: some View {
        VStack {
            if viewModel.connects {
                //VerifyView 불러오기
            } else {
                Text("HeyTaxi")
                    .bold()
                    
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
