//
//  VerifyView.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/07.
//

import SwiftUI

struct VerifyView: View {
    @State private var phoneNumber = ""
    @StateObject private var viewModel = VerifyViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 30) {
                Text("전화번호를 입력해주세요")
                    .bold()
                    .foregroundColor(.mainGreen)
                    .font(Font.custom("JalnanOTF", size: 30))
                    .frame(width: 380, height: 50)
                
                TextField("전화번호", text: $phoneNumber)
                    .frame(width: 350, height: 100)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                
                NavigationLink(destination: VerifiedView(phoneNumber: phoneNumber), isActive: $viewModel.success) {
                    Button(action: {viewModel.verifyRequest(phone: phoneNumber)}) {
                        Text("인증 요청")
                            .frame(width: 220, height: 50)
                    }
                }
                .background(Color.mainGreen)
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(Font.body.bold())
                .frame(width: 220)
                
                Spacer()
            }
            .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
        }
    }
}

struct VerifyView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyView()
    }
}
