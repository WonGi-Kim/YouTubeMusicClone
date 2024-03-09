//
//  HomeViewModel.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/13/23.
//

import Foundation
import SwiftUI
import Swift
import Kingfisher

enum SourceView {
    //  createSmallSizeCell 함수는 quickView와 shortsView가 공유하기 때문에 호출한 뷰의 유형을 전달
    case ShortsView
    case QuickSelectView
}

class HomeViewModel: ObservableObject {
    @ObservedObject var quickSelectViewModel = QuickSelectViewModel()
    @ObservedObject var shortsViewModel = ShortsViewModel()
    @ObservedObject var groupBoxViewModel = GroupBoxViewModel()
    @ObservedObject var listenAgainViewModel = ListenAgainViewModel()
    
    @Published var isMusicPlayerPresent: Bool = false
    
    //  셀 생성 함수
    func createSmallSizeCell(smallListSections : Binding<SmallListItemInfo>, sourceView: SourceView) -> some View {
        HStack(spacing: 10) {
            Button { [self] in
                quickSelectViewModel.dataSet(value: smallListSections, sourceView: sourceView)
                isMusicPlayerPresent.toggle()
            } label: {
                let url = URL(string: smallListSections.thumbnailUrl.wrappedValue)
                KFImage(url)
                    .resizable()
                    .frame(
                        width: 100,
                        height: 60
                    )
                VStack(alignment: .leading ,spacing: 5) {
                    Text(smallListSections.title.wrappedValue)
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(smallListSections.owner.wrappedValue)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
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
    
    //  Create Middle Size Cell
    func createMiddleSizeCell(middleListSections: Binding<SmallListItemInfo>) -> some View {
        Button { [self] in
            listenAgainViewModel.dataSet(value: middleListSections)
        } label: {
            VStack(alignment: .leading, spacing: 5){
                let test = URL(string: middleListSections.thumbnailUrl.wrappedValue)
                KFImage(test)
                    .resizable()
                    .frame(width: 140, height: 140) //  이미지 프레임 설정
                    //.clipShape(.rect(cornerRadius: 100))
                    .cornerRadius(5)
                Text(middleListSections.title.wrappedValue)
                    .font(.system(size: 15))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: 140, minHeight: 40, alignment: .leading)
            }
        }
    }
    
    //  셀 생성 함수
    func createSmallSizeCellInBox(smallListSections : Binding<SmallListItemInfo>) -> some View {
        HStack(spacing: 10) {
            Button { [self] in
                groupBoxViewModel.dataSet(value: smallListSections)
            } label: {
                let url = URL(string: smallListSections.thumbnailUrl.wrappedValue)
                KFImage(url)
                    .resizable()
                    .frame(
                        width: 100,
                        height: 60
                    )
                VStack(alignment: .leading ,spacing: 5) {
                    Text(smallListSections.title.wrappedValue)
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(smallListSections.owner.wrappedValue)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: 200)
                
                
                Button {
                    
                } label: {
                    Image("menu")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(.gray)
                }
                .frame(width: 30, height: 30)

            }
        }
    }
}
