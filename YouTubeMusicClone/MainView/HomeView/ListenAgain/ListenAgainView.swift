//
//  ListenAgainView.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/14/23.
//

import SwiftUI

struct ListenAgainView: View {
    @ObservedObject var mainViewModel = MainViewModel()
    @ObservedObject var homeViewModel = HomeViewModel()
    
    @StateObject var listenAgainViewModel = ListenAgainViewModel()
    
    //@State var middleSizeItemSections : [SmallListItemInfo] = []
    @State var playListId: String = "RDAMVMZjIPFe0hE4Y"
    
    @Binding var userTokenOnListenAgainView : String
    
    var body: some View {
        VStack {
            HStack {
                Image("Gi")
                    .resizable()
                    .frame(width: 40,height: 40)
                    .clipShape(Circle())
                VStack {
                    HStack {
                        Text("김원기")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack {
                        Text("다시 듣기")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                Spacer()
                Button {
                    // 더보기 버튼
                } label: {
                    Text("더보기")
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
                LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(listenAgainViewModel.ListenAgainSections.indices, id: \.self) { index in
                        homeViewModel.createMiddleSizeCell(middleListSections: $listenAgainViewModel.ListenAgainSections[index])
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10)) // Optional: 여백 조절
            }
        }
        .onAppear() {
            mainViewModel.callYoutubeApi(accessToken: userTokenOnListenAgainView, playListId: playListId) { result in
                switch result {
                case .success(let value):
                    mainViewModel.settingForInfo(value: value) { result in
                        switch result {
                        case .success(let data):
                            listenAgainViewModel.ListenAgainSections = data
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

