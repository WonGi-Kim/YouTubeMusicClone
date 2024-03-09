//
//  GroupBoxInfo.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/15/23.
//

import Foundation

struct GroupBoxInfo: Decodable {
    var id: String  // GroupBoxDecodable에서
    var thumbnailUrl: String
    var channelTitle: String
    var title: String
    var description: String
    
}
