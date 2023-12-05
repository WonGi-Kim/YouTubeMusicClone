//
//  YouTubeMusicCloneApp.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/4/23.
//

import GoogleSignIn
import GoogleSignInSwift
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth
import FirebaseAppCheck


@main
struct YourApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    //let persistenceController = persistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //  앱 체크를 위한 임시 디버그 토큰 발급
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)

        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}

//  앱 체크를 위한 클래스
class YourSimpleAppCheckProviderFactory:NSObject, AppCheckProviderFactory  {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        return AppAttestProvider(app: app)
    }
    
    
}
