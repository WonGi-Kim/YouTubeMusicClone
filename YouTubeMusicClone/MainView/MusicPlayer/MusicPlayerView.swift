//
//  MusicPlayerView.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/16/23.
//

import SwiftUI

struct MusicPlayerView: View {
    @ObservedObject var musicPlayerViewModel: MusicPlayerViewModel
    
    
    var body: some View {
        if let musicInfo = musicPlayerViewModel.musicInfo {
            // 데이터가 있는 경우
            VStack {
                Text(musicInfo.title)
                // 다른 데이터를 사용하여 View를 구성할 수 있음
                // 예: 이미지 표시 등
            }
        } else {
            // 데이터가 없는 경우
            Text("No music information available")
        }
    }
}

