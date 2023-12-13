//
//  HomeView.swift
//  YouTubeorMusic
//
//  Created by 김원기 on 11/30/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var mainViewModel = MainViewModel()
    
    @State var themeListHomeView : [String] = []
    
    @Binding var userTokenOnHomeView : String
    
    var body: some View {
        ScrollView {
            VStack {
                //  상단 탭
                TopView()
                
                //  가로 스크롤 (ex: 행복한 기분, 운동, ... )
                ThemeHorizontalScrollView(themeListHomeView: $themeListHomeView)
                
                //  빠른 선곡 탭
                QuickSelectView(userTokenOnQuickSelectView: $userTokenOnHomeView)
                
                //  Shorts에서 들은 음악 탭
                ShortsView(userTokenOnShortsView: $userTokenOnHomeView)
                
            }
        }
        .onAppear {
            mainViewModel.loadThemeList()
            themeListHomeView = mainViewModel.themeArray
        }
    }
}
/**
#Preview {
    @State var userTokenOnHomeView: String = ""
    HomeView(userTokenOnHomeView: $userTokenOnHomeView)
}
*/
