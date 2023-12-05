//
//  MainView.swift
//  YouTubeorMusic
//
//  Created by 김원기 on 11/30/23.
//  Api key : AIzaSyCKDejJilMjIUkW6vvqZoqIwDooyVtXmGs

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView(selection: .constant(1),
                content:  {
            HomeView()
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
    }
}

#Preview {
    MainView()
}
