//
//  HomeView.swift
//  YouTubeorMusic
//
//  Created by 김원기 on 11/30/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var mainViewModel: MainViewModel // 타입이 아닌 인스턴스를 저장할 프로퍼티
        
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
    @State var themeListHomeView : [String] = []
    
    var body: some View {
        ScrollView {
            VStack {
                //  상단 탭
                TopView()
                
                //  가로 스크롤 (ex: 행복한 기분, 운동, ... )
                ThemeHorizontalScrollView(themeListHomeView: $themeListHomeView)
                
                //  빠른 선곡 탭
                QuickSelectView(mainViewModel: mainViewModel)
                
            }
        }
        .onAppear {
            mainViewModel.loadThemeList()
            themeListHomeView = mainViewModel.themeArray
            print("HoemView에서 mainViewModel.quickSelections: \(mainViewModel.quickSelections)")
        }
    }
}

#Preview {
    HomeView(mainViewModel: MainViewModel())
}
