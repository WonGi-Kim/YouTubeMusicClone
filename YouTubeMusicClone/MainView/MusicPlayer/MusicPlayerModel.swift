//
//  MusicPlayerModel.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/16/23.
//

import SwiftUI

struct MusicPlayerModel: View {
    
    @ObservedObject var musicPlayerViewModel = MusicPlayerViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
