//
//  LoginView.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/7/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @ObservedObject var mainViewModel = MainViewModel()
    @State var userToken : String = ""
    
    var body: some View {
        GoogleSignInButton(
            scheme: .light,
            style: .wide,
            action: {
                DispatchQueue.main.async {
                    mainViewModel.signInGoogle { result in
                        switch result {
                        case .success(let token):
                            userToken = token
                        case .failure(let error):
                            print(error)
                        }
                    }
                    
                }
            }
        )
        .frame(width: 300, height: 60, alignment: .center)
        .fullScreenCover(isPresented: $mainViewModel.isShowFullScreenCover) {
            MainView(userTokenOnMainView: $userToken)
        }
    }
}
/**
#Preview {
    LoginView()
}
*/
