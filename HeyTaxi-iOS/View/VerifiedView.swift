//
//  VerifiedView.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/07.
//

import SwiftUI

struct VerifiedView: View {
    private let phoneNumber: String
    @State private var code = ""
    @StateObject private var viewModel: VerifiedViewModel()
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Text("인증번호를 입력해주세요")
                .bold()
                .foregroundColor(.mainGreen)
                .font(Font.custom("JalnanOTF", size: 30))
                .frame(width: 380, height: 50)
            
            TextField("인증번호", text: $code)
                .frame(width: 200, height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
            
        }
    }
}

struct VerifiedView_Previews: PreviewProvider {
    static var previews: some View {
        VerifiedView(phoneNumber: "")
    }
}
