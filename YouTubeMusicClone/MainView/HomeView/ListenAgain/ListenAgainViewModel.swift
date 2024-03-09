//
//  ListenAgainViewModel.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/18/23.
//

import Foundation
import SwiftUI

class ListenAgainViewModel: ObservableObject {
    
    @Published var ListenAgainSections: [SmallListItemInfo] = []
    @Published var ListenAgainSection: SmallListItemInfo = SmallListItemInfo(
        id: "",
        videoId: "",
        title: "",
        thumbnailUrl: "",
        thumbnailWidth: 0,
        thumbnailHeight: 0,
        owner: "")
    
    func dataSet(value: Binding<SmallListItemInfo>) {
        ListenAgainSection = value.wrappedValue
        print("Transferring ListenAgainViewModel to DataSet is successed.")
    }

}
