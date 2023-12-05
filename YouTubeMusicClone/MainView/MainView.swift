//
//  MainView.swift
//  YouTubeorMusic
//
//  Created by 김원기 on 11/30/23.

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct MainView: View {
    @ObservedObject private var mainViewModel = MainViewModel()
    
    var body: some View {
        TabView(selection: .constant(1),
                content:  {
            HomeView(mainViewModel: mainViewModel)
            .tabItem {
                Image(systemName: "music.note.house")
                Text("홈")
            }
            .tag(1)
            Text("Tab Content 2")
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("샘플")
                }.tag(2)
            Text("Tab Content 3")
                .tabItem {
                    Image(systemName: "safari")
                    Text("앱")
                }.tag(3)
            Text("Tab Content 4")
                .tabItem {
                    Image(systemName: "skateboard.fill")
                    Text("Arcade")
                }.tag(4)
        })
        .tint(.white)
        .padding(10)
        
        .onAppear {
            print("MainView에서 mainViewModel.quickSelections: \(mainViewModel.quickSelections)")
        }
    }
        
}

#Preview {
    MainView()
}
