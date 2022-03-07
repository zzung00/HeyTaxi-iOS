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
                
                //NavigationLink(destination: , label: <#T##() -> _#>)
            }
        }
    }
}

struct VerifyView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyView()
    }
}
