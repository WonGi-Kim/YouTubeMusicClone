//
//  QuickSelectView.swift
//  YouTubeorMusic
//
//  Created by 김원기 on 11/30/23.
//

import SwiftUI
import Kingfisher

struct QuickSelectView: View {
    @ObservedObject var mainViewModel: MainViewModel // 타입이 아닌 인스턴스를 저장할 프로퍼티
    @State var quickSelections: [QuickSelectItemInfo] = []
    @State var quickSelection: QuickSelectItemInfo = QuickSelectItemInfo(
        id: "",
        title: "",
        thumbnailUrl: "",
        thumbnailWidth: 0,
        thumbnailHeight: 0,
        owner: "")
        
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
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
        }
        .onAppear() {
            print("QuickView에서 mainViewModel.quickSelections: \(mainViewModel.quickSelections)")
        }
    }
        
    
    func createCell(quickSelections : Binding<QuickSelectItemInfo>) -> some View {
        HStack(spacing: 10) {
            Button {
                
            } label: {
                let url = URL(string: quickSelections.thumbnailUrl.wrappedValue)

            }
        }
    }
}

#Preview {
    QuickSelectView(mainViewModel: MainViewModel())
}
