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
    @State var quickSelections: [QuickSelectItemInfo] = []
    @State var quickSelection: QuickSelectItemInfo = QuickSelectItemInfo(
        id: "",
        title: "",
        thumbnailUrl: "",
        thumbnailWidth: 0,
        thumbnailHeight: 0,
        owner: "")
    @State var selectedIndex : Int = 0
    
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
                        Text("빠른 선택")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                Spacer()
                
                // Button
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
            
            ScrollView(.horizontal) {
                /**
                 LazyHGrid를 사용하여 가로로 스크롤 가능한 그리드 생성
                 rows 변수를 통해 한 행에 몇개의 아이템이 들어갈지 설정
                 GridItem(.flexible()) 4개 넣어서 4행까지 생성
                 */
                LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(quickSelections.indices, id: \.self) { index in
                        createCell(quickSelections: $quickSelections[index])
                    }
                }
                .padding(15) // Optional: 여백 조절
            }
            
            .onAppear() {
                mainViewModel.callYoutubeApi(accessToken: userTokenOnQuickSelectView, playListId: playListId) { result in
                    switch result {
                    case .success(let value):
                        mainViewModel.quickselectInfo(value: value) { result in
                            switch result {
                            case .success(let data):
                                quickSelections = data
                            case .failure(let error):
                                print("error")
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    func createCell(quickSelections : Binding<QuickSelectItemInfo>) -> some View {
        HStack(spacing: 10) {
            Button {
                
            } label: {
                let url = URL(string: quickSelections.thumbnailUrl.wrappedValue)
                KFImage(url)
                    .resizable()
                    .frame(
                        width: 100,
                        height: 60
                    )
                VStack(alignment: .leading ,spacing: 5) {
                    Text(quickSelections.title.wrappedValue)
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(quickSelections.owner.wrappedValue)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: 220)
                
                
                Button {
                    
                } label: {
                    Image("menu")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(.gray)
                }
                .frame(width: 30, height: 30)

            }
            Spacer()
        }
    }
}
/**
#Preview {
    @State var userTokenOnQuickSelectView: String = ""
    QuickSelectView(userTokenOnQuickSelectView: $userTokenOnQuickSelectView)
}
*/
