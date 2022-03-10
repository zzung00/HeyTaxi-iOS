//
//  ProfileView.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/08.
//

import SwiftUI

struct ProfileView: View {
    @State private var name = ""
    @State private var username = ""
    @StateObject private var viewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: "person")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.mainGreen)
                    .frame(width: 200, height: 200)
                
                Spacer()
                
                TextField("성명", text: $name)
                    .frame(width: 300, height: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                    .disableAutocorrection(true)
                
                TextField("사용자 이름", text: $username)
                    .frame(width: 300, height: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                    .disableAutocorrection(true)
                
                Spacer()
            }
            .onAppear {
                viewModel.loadMe {
                    user in
                    name = user.name!
                    username = user.username!
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                        Text("취소")
                            .bold()
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.user?.name = name
                        viewModel.updateMe(user: viewModel.user!)
                        
                    }) {
                        Text("저장")
                            .bold()
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
