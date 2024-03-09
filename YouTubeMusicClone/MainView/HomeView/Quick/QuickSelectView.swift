//
//  QuickSelectView.swift
//  YouTubeorMusic
//
//  Created by 김원기 on 11/30/23.
//

import SwiftUI
import Kingfisher

struct QuickSelectView: View {
    @ObservedObject var mainViewModel = MainViewModel()
    @ObservedObject var homeViewModel = HomeViewModel()
    @StateObject var quickSelectViewModel = QuickSelectViewModel()
    
    @Binding var userTokenOnQuickSelectView : String
    @State var playListId: String = "PLFgquLnL59alGJcdc0BEZJb2p7IgkL0Oe" // 한국 인기 플레이리스트 id
    var body: some View {
        VStack {
            HStack {
                // Text
                VStack {
                    HStack {
                        Text("이 노래로 뮤직 스테이션 시작하기")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack {
                        Text("빠른 선곡")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                Spacer()
                
                // 모두 재생 Button
                Button {
                    //  모두 재생 구현
                } label: {
                    Text("모두 재생")
                        .padding(5)
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(quickSelectViewModel.quickListSections.indices, id: \.self) { index in
                        homeViewModel.createSmallSizeCell(smallListSections: $quickSelectViewModel.quickListSections[index], sourceView: .QuickSelectView)
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
            }
            
            .sheet(isPresented: $homeViewModel.isMusicPlayerPresent) {
                MusicPlayerView(musicPlayerViewModel: quickSelectViewModel.musicPlayerViewModel)
            }
            .onAppear() {
                mainViewModel.callYoutubeApi(accessToken: userTokenOnQuickSelectView, playListId: playListId) { result in
                    switch result {
                    case .success(let value):
                        mainViewModel.settingForInfo(value: value) { result in
                            switch result {
                            case .success(let data):
                                quickSelectViewModel.quickListSections = data
                            case .failure(_):
                                print("error2")
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}

/**
 LazyHGrid를 사용하여 가로로 스크롤 가능한 그리드 생성
 rows 변수를 통해 한 행에 몇개의 아이템이 들어갈지 설정
 GridItem(.flexible()) 4개 넣어서 4행까지 생성
 */
