//  MARK: YouTubeApi
func callYoutubeApi(accessToken: GIDToken, completion: @escaping (Result<DecodableModel, YouTubeAPIError>) -> Void) {
    
    let apiUrl = "https://youtube.googleapis.com/youtube/v3/playlistItems"
    let apiKey = "Your_Api_key"
    //let accessToken = ""
    
    let parameters: [String: Any] = [
        "part": "snippet",
        "maxResults": "1",
        "playlistId": "PLFgquLnL59alGJcdc0BEZJb2p7IgkL0Oe",
        "key": apiKey
    ]

    let headers: HTTPHeaders = [
        "Authorization": "Bearer \(accessToken.tokenString)",
        "Accept": "application/json"
    ]

    AF.request(apiUrl, method: .get, parameters: parameters, headers: headers)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                // 성공적으로 데이터를 얻었을 때의 처리
                print("AF.request.success.value: \(value)")
            case .failure(let error):
                // 에러가 발생했을 때의 처리
                print("AF.request.failure.value: \(error)")
            }
        }
}

 [Request]: GET https://youtube.googleapis.com/youtube/v3/playlistItems?key=[Your_Api_key]&maxResults=1&part=snippet&playlistId=PLFgquLnL59alGJcdc0BEZJb2p7IgkL0Oe
     [Headers]:
         Accept: application/json
         Authorization: Bearer [Your_Access_Token]
 [Body]: None
[Response]:
 [Status Code]: 403
 [Headers]:
     Alt-Svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000
     Cache-Control: private
     Content-Encoding: gzip
     Content-Length: 329
     Content-Type: application/json; charset=UTF-8
     Date: Sat, 09 Dec 2023 04:37:02 GMT
     Server: scaffolding on HTTPServer2
     Vary: Origin, X-Origin, Referer
     Www-Authenticate: Bearer realm="https://accounts.google.com/", error="insufficient_scope", scope="https://www.googleapis.com/auth/youtube https://www.gdata.youtube.com https://gdata.youtube.com/ https://gdata.youtube.com http://gdata.youtube.com http://gdata.youtube.com/ https://gdata.youtube.com/feeds/ http://gdata.youtube.com/feeds/api/videos/ http://gdata.youtube.com/feeds/api/users/default/playlists http://gdata.youtube.com/youtube https://gdata.youtube.com/feeds/api/users/default/favorites/ https://gdata.youtube.com/feeds/api https://gdata.youtube.com/captions https://gdata.youtube.com/feed https://www.googleapis.com/auth/youtubepartner https://www.googleapis.com/auth/youtube.readonly https://www.googleapis.com/auth/youtube.force-ssl"
     x-content-type-options: nosniff
     x-frame-options: SAMEORIGIN
     x-xss-protection: 0
 [Body]:
     {
       "error": {
         "code": 403,
         "message": "Request had insufficient authentication scopes.",
         "errors": [
           {
             "message": "Insufficient Permission",
             "domain": "global",

             "reason": "insufficientPermissions"
           }
         ],
         "status": "PERMISSION_DENIED",
         "details": [
           {
             "@type": "type.googleapis.com/google.rpc.ErrorInfo",
             "reason": "ACCESS_TOKEN_SCOPE_INSUFFICIENT",   //  충분한 스코프가 없다고 오류가 발생한다.
             "domain": "googleapis.com",
             "metadata": {
               "service": "youtube.googleapis.com",
               "method": "youtube.api.v3.V3DataPlaylistItemService.List"
             }
           }
         ]
       }
     }
[Network Duration]: 0.3153790235519409s
[Serialization Duration]: 1.14166468847543e-05s
[Result]: failure(Alamofire.AFError.responseValidationFailed(reason: Alamofire.AFError.ResponseValidationFailureReason.unacceptableStatusCode(code: 403)))


해결 방법은 Headers 부분에
let headers: HTTPHeaders = [
    "Authorization": "Bearer \(accessToken.tokenString)",
    "Authorization": "https://www.googleapis.com/auth/youtube.force-ssl",
    "Accept": "application/json"
]
"Authorization": "https://www.googleapis.com/auth/youtube.force-ssl" 한줄을 추가하는 것으로 해결된다.


AF.request.success.value: DecodableModel(
    kind: "youtube#playlistItemListResponse",
    etag: "db9q7stvLjdKYs-Me18q8DrWwIw",
    nextPageToken: "EAAaL1BUOkNBSWlFRUV3TTBGRlJESXdORFUwT1RneU1UTW9BVWpoMG9XbXlvR0RBMUFC",
    items: [YouTubeMusicClone.PlaylistItem
            (
                kind: "youtube#playlistItem",
                etag: "1FFOIzfjYKnbCCZyM9miHm7j7_0",
                id: "UExGZ3F1TG5MNTlhbEdKY2RjMEJFWkpiMnA3SWdrTDBPZS5DMjE1OTIwN0QzMEI4MjhD",
                snippet: YouTubeMusicClone.Snippet(
                    publishedAt: "2023-12-09T05:05:02Z",
                    channelId: "UC-9-kyTW8ZkZNDHQJ6FgpwQ",
                    title: "Drama",
                    description: "Provided to YouTube by SM Entertainment\n\nDrama · aespa\n\nDrama - The 4th Mini Album\n\n℗ 2023 SM Entertainment\n\nReleased on: 2023-11-10\n\nProducer: No Identity\nLyricist: Bang Hyehyun\nLyricist: Ellie Suh\nComposer, Arranger: No Identity\nComposer: Waker\nComposer: EJAE\nComposer: Charlotte Wilson\n\nAuto-generated by YouTube.",
                    thumbnails: YouTubeMusicClone.Thumbnails(
                        defaultThumbnail: YouTubeMusicClone.Thumbnail(url: "https://i.ytimg.com/vi/S3Z6N7U7f6I/default.jpg", width: 120, height: 90),
                        medium: YouTubeMusicClone.Thumbnail(url: "https://i.ytimg.com/vi/S3Z6N7U7f6I/mqdefault.jpg", width: 320, height: 180),
                        high: YouTubeMusicClone.Thumbnail(url: "https://i.ytimg.com/vi/S3Z6N7U7f6I/hqdefault.jpg", width: 480, height: 360),
                        standard: YouTubeMusicClone.Thumbnail(url: "https://i.ytimg.com/vi/S3Z6N7U7f6I/sddefault.jpg", width: 640, height: 480),
                        maxres: YouTubeMusicClone.Thumbnail(url: "https://i.ytimg.com/vi/S3Z6N7U7f6I/maxresdefault.jpg", width: 1280, height: 720)),
                    channelTitle: "Music",
                    playlistId: "PLFgquLnL59alGJcdc0BEZJb2p7IgkL0Oe",
                    position: 0,
                    resourceId: YouTubeMusicClone.ResourceId(
                        kind: "youtube#video",
                        videoId: "S3Z6N7U7f6I"),
                    videoOwnerChannelTitle: "aespa - Topic",
                    videoOwnerChannelId: "UCEdZAdnnKqbaHOlv8nM6OtA")
            ),
            YouTubeMusicClone.PlaylistItem
            (
                kind: "youtube#playlistItem",
                etag: "pDVfVVH27J5I_SgqUDsVTRcuIYM",
                id: "UExGZ3F1TG5MNTlhbEdKY2RjMEJFWkpiMnA3SWdrTDBPZS4xMEFGQ0YzQTc0QjU1ODgw",
                snippet: YouTubeMusicClone.Snippet(
                    publishedAt: "2023-12-09T05:05:02Z",
                    channelId: "UC-9-kyTW8ZkZNDHQJ6FgpwQ",
                    title: "Chill Kill",
                    description: "Provided to YouTube by SM Entertainment\n\nChill Kill · Red Velvet\n\nChill Kill - The 3rd Album\n\n℗ 2023 SM Entertainment\n\nReleased on: 2023-11-13\n\nProducer: KENZIE\nProducer: Moonshine\nLyricist, Composer, Arranger: KENZIE\nComposer: Jonatan Gusmark\nComposer: Ludvig Evers\nComposer: Moa “Cazzi Opeia” Carlebecker\nComposer: Ellen Berg\nArranger: Moonshine\n\nAuto-generated by YouTube.",
                    thumbnails: YouTubeMusicClone.Thumbnails(
                        defaultThumbnail: YouTubeMusicClone.Thumbnail(url: "https://i.ytimg.com/vi/WfB4sNA0W9M/default.jpg", width: 120, height: 90),
                        medium: YouTubeMusicClone.Thumbnail(url: "https://i.ytimg.com/vi/WfB4sNA0W9M/mqdefault.jpg", width: 320, height: 180),
                        high: YouTubeMusicClone.Thumbnail(url: "https://i.ytimg.com/vi/WfB4sNA0W9M/hqdefault.jpg", width: 480, height: 360), 
                        standard: YouTubeMusicClone.Thumbnail(url: "https://i.ytimg.com/vi/WfB4sNA0W9M/sddefault.jpg", width: 640, height: 480),
                        maxres: YouTubeMusicClone.Thumbnail(url: "https://i.ytimg.com/vi/WfB4sNA0W9M/maxresdefault.jpg", width: 1280, height: 720)),
                    channelTitle: "Music",
                    playlistId: "PLFgquLnL59alGJcdc0BEZJb2p7IgkL0Oe",
                    position: 1,
                    resourceId: YouTubeMusicClone.ResourceId(
                        kind: "youtube#video",
                        videoId: "WfB4sNA0W9M"),
                    videoOwnerChannelTitle: "Red Velvet - Topic",
                    videoOwnerChannelId: "UCHmZYTfdTyVKQEJicLiXEOg")
            )
           ]
)


2
ScrollView(.horizontal) {
    //  LazyHGrid를 사용하여 가로로 스크롤 가능한 그리드 생성
    //  rows 변수를 통해 한 행에 몇개의 아이템이 들어갈지 설정
    //  GridItem(.flexible()) 4개 넣어서 4행까지 생성
    LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
        ForEach(quickSelections.indices, id: \.self) { index in
            createCell(quickSelections: $quickSelections[index])
        }
    }
    .padding(15) // Optional: 여백 조절
}


[Request]: GET https://youtube.googleapis.com/youtube/v3/playlistItems?key=AIzaSyBfEXIEnPr4S2YDAMREcp_KJmDjhsPnaC0&maxResults=20&part=snippet&playlistId=PLbO2kHOIx8kAyRyLARo-J-QkPps6uJ3gp
    [Headers]:
        Accept: application/json
        Authorization: https://www.googleapis.com/auth/youtube.force-ssl
    [Body]: None
[Response]:
    [Status Code]: 200
    [Headers]:
        Alt-Svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000
        Cache-Control: private
        Content-Encoding: gzip
        Content-Length: 5502
        Content-Type: application/json; charset=UTF-8
        Date: Wed, 13 Dec 2023 06:52:43 GMT
        Server: scaffolding on HTTPServer2
        Vary: Origin, X-Origin, Referer
        x-content-type-options: nosniff
        x-frame-options: SAMEORIGIN
        x-xss-protection: 0
    [Body]:
        {
          "kind": "youtube#playlistItemListResponse",
          "etag": "ZozenQq8mhiqeJ3ZEXUQc6I1i2M",
          "items": [
            {
              "kind": "youtube#playlistItem",
              "etag": "9FcV80UQeszpO2FfQ-86QezkgrY",
              "id": "UExiTzJrSE9JeDhrQXlSeUxBUm8tSi1Ra1BwczZ1SjNncC4yMDhBMkNBNjRDMjQxQTg1",
              "snippet": {
                "publishedAt": "2023-09-30T04:49:24Z",
                "channelId": "UCp-C9wmgAXn1sBo417wtqhw",
                "title": "I Love My Body",
                "description": "Provided to YouTube by AdShare for a Third party\n\nI Love My Body · Hwa Sa\n\nI Love My Body\n\n℗ P NATION\n\nComposer: Shinae An\nComposer: Yoo Gun Hyung\nLyricist: Shinae An\nArranger: Yoo Gun Hyung\n\nAuto-generated by YouTube.",
                "thumbnails": {
                  "default": {
                    "url": "https://i.ytimg.com/vi/zYrUAq5no-k/default.jpg",
                    "width": 120,
                    "height": 90
                  },
                  "medium": {
                    "url": "https://i.ytimg.com/vi/zYrUAq5no-k/mqdefault.jpg",
                    "width": 320,
                    "height": 180
                  },
                  "high": {
                    "url": "https://i.ytimg.com/vi/zYrUAq5no-k/hqdefault.jpg",
                    "width": 480,
                    "height": 360
                  },
                  "standard": {
                    "url": "https://i.ytimg.com/vi/zYrUAq5no-k/sddefault.jpg",
                    "width": 640,
                    "height": 480
                  },
                  "maxres": {
                    "url": "https://i.ytimg.com/vi/zYrUAq5no-k/maxresdefault.jpg",
                    "width": 1280,
                    "height": 720
                  }
                },
                "channelTitle": "수리 수리 묘수리",
                "playlistId": "PLbO2kHOIx8kAyRyLARo-J-QkPps6uJ3gp",
                "position": 0,
                "resourceId": {
                  "kind": "youtube#video",
                  "videoId": "zYrUAq5no-k"
                },
                "videoOwnerChannelTitle": "HWASA - Topic",
                "videoOwnerChannelId": "UCUvwlcYiGH78yDWofEvRQ2A"
              }
            },
