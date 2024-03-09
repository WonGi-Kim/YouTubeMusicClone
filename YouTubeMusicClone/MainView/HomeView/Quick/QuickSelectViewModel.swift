//
//  QuickSelectViewModel.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/16/23.
//

import Foundation
import SwiftUI

class QuickSelectViewModel: ObservableObject {
    @ObservedObject var musicPlayerViewModel = MusicPlayerViewModel()
    
    @Published var quickListSections: [SmallListItemInfo] = []
    @Published var quickListSection: SmallListItemInfo = SmallListItemInfo(
        id: "",
        videoId: "",
        title: "",
        thumbnailUrl: "",
        thumbnailWidth: 0,
        thumbnailHeight: 0,
        owner: "")
    
    func dataSet(value: Binding<SmallListItemInfo>, sourceView: SourceView) {
        quickListSection = value.wrappedValue
        musicPlayerViewModel.updateMusicInfo(quickListSection)
    }

}
