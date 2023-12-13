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

class HomeViewModel: ObservableObject {
    
    //  셀 생성 함수
    func createCell(smallListSections : Binding<SmallListItemInfo>) -> some View {
        HStack(spacing: 10) {
            Button {
                
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
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(smallListSections.owner.wrappedValue)
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
