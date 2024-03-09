//
//  MainViewModel.swift
//  YouTubeorMusic
//
//  Created by 김원기 on 11/30/23.
//

import Foundation
import SwiftUI
import Alamofire
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore
import Firebase
import FirebaseAuth

// YouTubeAPIError 정의
enum YouTubeAPIError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case requestFailed(Int)

    // 새로운 케이스 추가 - JSON 디코딩 에러
    case jsonDecodingError(Error)
}

class MainViewModel: ObservableObject {
    
    @Published var themeArray: [String] = []
    @Published var decodedData: PlayListItemsDecodableModel?
    @Published var isShowFullScreenCover: Bool = false
    
    @Published var userToken: String = ""
    @Published var plaYListId: String = ""
    
    @Published var smallListItemSections: [SmallListItemInfo] = []{
        willSet {
            objectWillChange.send()
        }
    }
    
    
    @Published var smallListItemSection: SmallListItemInfo = SmallListItemInfo(
        id: "",
        videoId: "",
        title: "",
        thumbnailUrl: "",
        thumbnailWidth: 0,
        thumbnailHeight: 0,
        owner: "")
    
    @Published var playListSection: GroupBoxInfo = GroupBoxInfo(
        id: "",
        thumbnailUrl: "",
        channelTitle: "", 
        title: "",
        description: "")
    
    
    //  MARK: Plist Controll
    func loadThemeList() {
        if let plistPath = Bundle.main.path(forResource: "theme", ofType: "plist"),
            let themeArray = NSArray(contentsOfFile: plistPath) as? [[String: Any]] {
            self.themeArray = themeArray.compactMap { $0["theme"] as? String }
        }
    }
    
    //  MARK: YouTubeApi For PlayListItems
    func callYoutubeApi(accessToken: String ,playListId: String ,completion: @escaping (Result<PlayListItemsDecodableModel, YouTubeAPIError>) -> Void) {
        
        let apiUrl = "https://youtube.googleapis.com/youtube/v3/playlistItems"
        let apiKey = "AIzaSyBfEXIEnPr4S2YDAMREcp_KJmDjhsPnaC0"
        
        let parameters: [String: Any] = [
            "part": "snippet",
            "maxResults": "20",
            "playlistId": playListId,
            "key": apiKey
        ]

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Authorization": "https://www.googleapis.com/auth/youtube.force-ssl",
            "Accept": "application/json"
        ]

        AF.request(apiUrl, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: PlayListItemsDecodableModel.self) { response in
                //debugPrint(response)
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    // 에러가 발생했을 때의 처리
                    print("AF.request.failure.value: \(error)")
                }
            }
    }
    
    //  MARK: YouTubeAPI for PlayList
    func callYouTubeApiForPlayList(accessToken: String ,playListId: String ,completion: @escaping (Result<PlayListDecodableModel, YouTubeAPIError>) -> Void) {
        
        let apiUrl = "https://youtube.googleapis.com/youtube/v3/playlists"
        let apiKey = "AIzaSyBfEXIEnPr4S2YDAMREcp_KJmDjhsPnaC0"
        
        let parameters: [String: Any] = [
            "part": "snippet",
            "id": playListId,
            "key": apiKey
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Authorization": "https://www.googleapis.com/auth/youtube.force-ssl",
            "Accept": "application/json"
        ]
        
        AF.request(apiUrl, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: PlayListDecodableModel.self) { response in
                //debugPrint(response)
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    // 에러가 발생했을 때의 처리
                    print("AF.request.failure.value: \(error)")
                }
            }
    }
   
    //  MARK: SignInGoogle
    func signInGoogle(completion: @escaping (Result<String, Error>) -> Void) {
        
        print("로그인 버튼 눌림")
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        // Start the sign in flow!
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { user, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let user = user?.user,
                  let idToken = user.idToken else { return }
            
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { res, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                guard let user = res?.user else {
                    completion(.failure(YouTubeAPIError.invalidResponse))
                    return
                }
                
                self.isShowFullScreenCover = true
                
                let userToken = accessToken.tokenString
                completion(.success(userToken))
            }
        }
    }
    
    //  MARK: settingForInfo 구성
    func settingForInfo(value: PlayListItemsDecodableModel, completion: @escaping (Result<[SmallListItemInfo], Error>) -> Void) {
        let data = value
        
        for playlistItem in data.items {
            
            smallListItemSection.id = playlistItem.id
          
            let snippet = playlistItem.snippet
            let title = snippet.title
            smallListItemSection.title = title
            
            let thumbnails = snippet.thumbnails
            let defaultThumbnail = thumbnails.defaultThumbnail
            let maxres = thumbnails.maxres
            smallListItemSection.thumbnailUrl = maxres?.url ?? defaultThumbnail.url
            smallListItemSection.thumbnailWidth = Float(defaultThumbnail.width)
            smallListItemSection.thumbnailHeight = Float(defaultThumbnail.height)
            
            let resourceId = snippet.resourceId
            let videoId = resourceId.videoId
            smallListItemSection.videoId = videoId
            
            let titleOwner = snippet.videoOwnerChannelTitle
            if let index = titleOwner.range(of: " - Topic") {
                smallListItemSection.owner = titleOwner[..<index.lowerBound].trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                print("error")
            }
            
            smallListItemSections.append(smallListItemSection)
        }
        completion(.success(smallListItemSections))
    }
    
    //  MARK: settingForPlayListInfo
    func settingForPlayListInfo(value: PlayListDecodableModel, completion: @escaping(Result<GroupBoxInfo, Error>) -> Void) {
        let data = value
        
        for playList in data.items {
            playListSection.id = playList.id
            
            let snippet = playList.snippet
            
            let thumbnails = snippet.thumbnails
            let maxres = thumbnails.maxres
            playListSection.thumbnailUrl = maxres.url
            
            let title = snippet.title
            playListSection.title = title
            
            let channelTitle = snippet.channelTitle
            playListSection.channelTitle = channelTitle
            
            let description = snippet.description
            playListSection.description = description
        }
        completion(.success(playListSection))
    }
}
