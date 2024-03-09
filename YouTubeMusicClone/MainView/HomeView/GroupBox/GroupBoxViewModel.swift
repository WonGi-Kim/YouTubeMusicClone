//
//  GroupBoxViewModel.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/18/23.
//

import Foundation
import SwiftUI

class GroupBoxViewModel: ObservableObject {
    
    @Published var groupBoxListSections: [SmallListItemInfo] = []
    @Published var groupBoxListSection: SmallListItemInfo = SmallListItemInfo(
        id: "",
        videoId: "",
        title: "",
        thumbnailUrl: "",
        thumbnailWidth: 0,
        thumbnailHeight: 0,
        owner: "")
    
    @Published var groupBoxInfo : GroupBoxInfo = GroupBoxInfo(id: "", thumbnailUrl: "", channelTitle: "", title: "", description: "")
    
    func dataSet(value: Binding<SmallListItemInfo>) {
        groupBoxListSection = value.wrappedValue
        print("Transferring GroupBox to DataSet is successed.")
    }

}
