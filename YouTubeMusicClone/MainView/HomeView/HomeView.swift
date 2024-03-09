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
        ScrollView(showsIndicators: false){
            VStack {
                //  상단 탭
                TopView()
                
                //  가로 스크롤 (ex: 행복한 기분, 운동, ... )
                LazyVStack(pinnedViews: .sectionHeaders) {
                    Section(header: ThemeHorizontalScrollView(themeListHomeView: $themeListHomeView)) {
                        VStack {
                            
                            //  빠른 선곡 탭
                            QuickSelectView(userTokenOnQuickSelectView: $userTokenOnHomeView)
                                .padding(.top, 10)

                            //  다시 듣기 탭
                            ListenAgainView(userTokenOnListenAgainView: $userTokenOnHomeView)
                                .padding(.top, 10)
                            
                            //  Shorts에서 들은 음악 탭
                            ShortsView(userTokenOnShortsView: $userTokenOnHomeView)
                                .padding(.top, 10)
                            
                            //  Billion group box
                            GroupBoxView(userTokenOnGroupBoxView: $userTokenOnHomeView)
                                .padding(.top, 10)
                            
                        }
                    }
                }
               
                
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
