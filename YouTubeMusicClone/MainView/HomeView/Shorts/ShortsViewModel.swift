//
//  ShortsViewModel.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/18/23.
//

import Foundation
import SwiftUI

class ShortsViewModel: ObservableObject {
    
    @Published var shortsSections: [SmallListItemInfo] = []
    @Published var shortsSection: SmallListItemInfo = SmallListItemInfo(
        id: "",
        videoId: "",
        title: "",
        thumbnailUrl: "",
        thumbnailWidth: 0,
        thumbnailHeight: 0,
        owner: "")
    
    func dataSet(value: Binding<SmallListItemInfo>) {
        shortsSection = value.wrappedValue
        print("Transferring QuickSelectViewModel to DataSet is successed.")
    }

}
