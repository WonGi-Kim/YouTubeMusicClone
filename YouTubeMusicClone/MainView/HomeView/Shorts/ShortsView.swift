//
//  ShortsView.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/13/23.
//

import SwiftUI

struct ShortsView: View {
    @ObservedObject var mainViewModel = MainViewModel()
    @ObservedObject var homeViewModel = HomeViewModel()
    @StateObject var shortsViewModel = ShortsViewModel()
    
    @Binding var userTokenOnShortsView : String
    
    //@State var smallListSections: [SmallListItemInfo] = []
    @State var playListId: String = "PLbO2kHOIx8kAyRyLARo-J-QkPps6uJ3gp"
    
    var body: some View {
        VStack {
            HStack {
                Text("Shorts에서 들은 음악")
                    .font(.title)
                    .fontWeight(.bold)
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
                    ForEach(shortsViewModel.shortsSections.indices, id: \.self) { index in
                        homeViewModel.createSmallSizeCell(smallListSections: $shortsViewModel.shortsSections[index], sourceView: .ShortsView)
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10)) // Optional: 여백 조절
            }
        }
        .onAppear() {
            mainViewModel.callYoutubeApi(accessToken: userTokenOnShortsView, playListId: playListId) { result in
                switch result {
                case .success(let value):
                    mainViewModel.settingForInfo(value: value) { result in
                        switch result {
                        case .success(let data):
                            shortsViewModel.shortsSections = data
                        case .failure(_):
                            print("error3")
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
