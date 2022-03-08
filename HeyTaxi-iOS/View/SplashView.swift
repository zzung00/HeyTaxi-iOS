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
                VerifyView()
            } else {
                Text("HeyTaxi")
                    .bold()
                    .foregroundColor(.mainGreen)
                    .font(Font.custom("JalnanOTF", size: 50))
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                viewModel.serverConnect()
            }
        })
        
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("HeyTaxi"), message: Text("서버에 연결 할 수 없습니다"), dismissButton: .default(Text("확인")))
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
