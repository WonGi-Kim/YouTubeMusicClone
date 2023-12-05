//
//  QuickSelectItemInfo.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/9/23.
//

import Foundation
import SwiftUI
import Swift

struct QuickSelectItemInfo: Decodable{
    var id: String
    var title: String
    var thumbnailUrl: String
    var thumbnailWidth: Float
    var thumbnailHeight: Float
    var owner: String
}
