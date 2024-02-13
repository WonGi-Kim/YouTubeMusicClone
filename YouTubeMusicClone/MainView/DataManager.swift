//
//  DataManager.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/16/23.
//

import Foundation

class DataManager: ObservableObject {
    
    @Published var musicInfo: SmallListItemInfo = SmallListItemInfo(
        id: "",
        videoId: "",
        title: "",
        thumbnailUrl: "",
        thumbnailWidth: 0,
        thumbnailHeight: 0,
        owner: "")
    
}
