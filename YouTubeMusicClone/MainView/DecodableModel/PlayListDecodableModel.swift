
import Foundation


struct PlayListDecodableModel: Decodable {
    let kind: String
    let etag: String
    let pageInfo: PageInfo
    let items: [Playlist]
}

struct PageInfo: Decodable {
    let totalResults: Int
    let resultsPerPage: Int
}

struct Playlist: Decodable {
    let kind: String
    let etag: String
    let id: String
    let snippet: SnippetOnPlayList
}

struct SnippetOnPlayList: Decodable {
    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
    let thumbnails: ThumbnailsOnPlayList
    let channelTitle: String
    let defaultLanguage: String
    let localized: Local
}

struct ThumbnailsOnPlayList: Decodable {
    let medium: ThumbnailOnPlayList
    let standard: ThumbnailOnPlayList
    let maxres: ThumbnailOnPlayList
}

struct ThumbnailOnPlayList: Decodable {
    let url: String
    let width: Int
    let height: Int
}

struct Local: Decodable {
    let title: String
    let description: String
}
