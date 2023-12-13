//
//  ShortsSelectItemInfo.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/13/23.
//

import Foundation
import SwiftUI
import Swift

struct ShortsSelectItemInfo: Decodable{
    var id: String
    var title: String
    var thumbnailUrl: String
    var thumbnailWidth: Float
    var thumbnailHeight: Float
    var owner: String
}
