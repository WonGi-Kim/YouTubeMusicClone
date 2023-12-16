//
//  DecodableModel.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/4/23.
//

import Foundation

struct PlayListItemsDecodableModel: Decodable {
    let kind: String
    let etag: String
    let nextPageToken: String?
    let items: [PlaylistItem]
}

struct PlaylistItem: Decodable {
    let kind: String
    let etag: String
    let id: String
    let snippet: Snippet
}

struct Snippet: Decodable {
    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let playlistId: String
    let position: Int
    let resourceId: ResourceId
    let videoOwnerChannelTitle: String
    let videoOwnerChannelId: String
}

struct Thumbnails: Decodable {
    let defaultThumbnail: Thumbnail
    let medium: Thumbnail
    let high: Thumbnail
    let standard: Thumbnail
    let maxres: Thumbnail?

    private enum CodingKeys: String, CodingKey {
        case defaultThumbnail = "default"
        case medium
        case high
        case standard
        case maxres
    }
}

struct Thumbnail: Decodable {
    let url: String
    let width: Int
    let height: Int
}

struct ResourceId: Decodable {
    let kind: String
    let videoId: String
}

