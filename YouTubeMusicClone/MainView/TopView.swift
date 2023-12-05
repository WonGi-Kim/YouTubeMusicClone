//
//  TopView.swift
//  YouTubeorMusic
//
//  Created by 김원기 on 11/30/23.
//

import SwiftUI

struct TopView: View {
    @ObservedObject var mainViewModel = MainViewModel()
    
    var body: some View {
        HStack {
            Image("youtubeMusicAppCloneLogo")
                .resizable()
                .frame(width: 40,height: 40)
            Text("Music")
                .font(.title)
                .fontWeight(.heavy)
            Spacer()
            
            Button {
                //  Search 버튼
                print("serach Button tapped")
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25,height: 25)
                    .foregroundColor(.white)
            }
            .padding()
            
            Button {
                //  UserView FullScreenCover or Sheet
            } label: {
                Image("Gi")
                    .resizable()
                    .frame(width: 40,height: 40)
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    TopView()
}
