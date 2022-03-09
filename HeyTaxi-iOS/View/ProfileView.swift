//
//  ProfileView.swift
//  HeyTaxi-iOS
//
//  Created by 이정현 on 2022/03/08.
//

import SwiftUI

struct ProfileView: View {
    @State private var username = ""
    @StateObject private var viewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                
            }
            .onAppear {
                viewModel.loadMe {
                    user in
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                        Text("취소")
                            .bold()
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
