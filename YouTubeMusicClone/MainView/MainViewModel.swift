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
    @Published var decodedData: DecodableModel?
    @Published var isShowFullScreenCover: Bool = false
    
    @Published var quickSelections: [QuickSelectItemInfo] = []{
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var quickSelection: QuickSelectItemInfo = QuickSelectItemInfo(
        id: "",
        title: "",
        thumbnailUrl: "",
        thumbnailWidth: 0,
        thumbnailHeight: 0,
        owner: "")
    
    
    //  MARK: Plist Controll
    func loadThemeList() {
        if let plistPath = Bundle.main.path(forResource: "theme", ofType: "plist"),
            let themeArray = NSArray(contentsOfFile: plistPath) as? [[String: Any]] {
            self.themeArray = themeArray.compactMap { $0["theme"] as? String }
        }
    }
    
    //  MARK: YouTubeApi
    func callYoutubeApi(accessToken: GIDToken, completion: @escaping (Result<DecodableModel, YouTubeAPIError>) -> Void) {
        
        let apiUrl = "https://youtube.googleapis.com/youtube/v3/playlistItems"
        let apiKey = "AIzaSyBfEXIEnPr4S2YDAMREcp_KJmDjhsPnaC0"
        //let accessToken = ""
        
        let parameters: [String: Any] = [
            "part": "snippet",
            "maxResults": "2",
            "playlistId": "PLFgquLnL59alGJcdc0BEZJb2p7IgkL0Oe",
            "key": apiKey
        ]

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken.tokenString)",
            "Authorization": "https://www.googleapis.com/auth/youtube.force-ssl",
            "Accept": "application/json"
        ]

        AF.request(apiUrl, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: DecodableModel.self) { response in
                switch response.result {
                case .success(let value):
                    // 성공적으로 데이터를 얻었을 때의 처리
                    self.quickselectInfo(value: value)
                case .failure(let error):
                    // 에러가 발생했을 때의 처리
                    print("AF.request.failure.value: \(error)")
                }
            }
        
        //  데이터 접근 방식
        /**
         // items 배열에 접근
             for playlistItem in value.items {
                 // 각각의 PlaylistItem에서 snippet 찾기
                 let snippet = playlistItem.snippet
                 // title 속성에 직접 접근
                 let title = snippet.title
                 print("Title: \(title)")
             }
         */
    }
   
    //  MARK: SignInGoogle
    func signInGoogle() {
        
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
            
            //  엑세스 토큰을 통해 api 호출
            self.callYoutubeApi(accessToken: accessToken) { result in
                switch result {
                case .success(let data):
                    print("Api Called: \(data)")
                case .failure(let error):
                    print("Api Error: \(error)")
                }
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { res, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                guard let user = res?.user else { return }
                
                self.isShowFullScreenCover = true
            }
        }
    }
    
    //  MARK: QuickselectInfo 구성
    func quickselectInfo(value: DecodableModel) {
        //  옵셔널 체이닝 진행
        let data = value
        
        for playlistItem in data.items {
            
            quickSelection.id = playlistItem.id
          
            let snippet = playlistItem.snippet
            let title = snippet.title
            quickSelection.title = title
            
            let thumbnails = snippet.thumbnails
            let defaultThumbnail = thumbnails.defaultThumbnail
            quickSelection.thumbnailUrl = defaultThumbnail.url
            quickSelection.thumbnailWidth = Float(defaultThumbnail.width)
            quickSelection.thumbnailHeight = Float(defaultThumbnail.height)
            
            let titleOwner = snippet.videoOwnerChannelTitle
            if let index = titleOwner.range(of: " - Topic") {
                quickSelection.owner = titleOwner[..<index.lowerBound].trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                print("error")
            }
            
            quickSelections.append(quickSelection)
        }
        print("quickSelections:\(quickSelections)")
    }
}

#Preview {
    LoginView()
}
