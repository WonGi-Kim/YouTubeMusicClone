//
//  ThemeHorizontalScrollView.swift
//  YouTubeorMusic
//
//  Created by 김원기 on 11/30/23.

import SwiftUI

struct ThemeHorizontalScrollView: View {
    @Binding var themeListHomeView: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(themeListHomeView, id: \.self) { theme in
                    Button {
                        // ... 버튼이 클릭되었을 때의 동작 ...
                    } label: {
                        Text(theme)
                            .foregroundColor(.white)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                    }
                }
            }
            .frame(height: 80)
            .padding(.top, -15)
        }
    }
}
