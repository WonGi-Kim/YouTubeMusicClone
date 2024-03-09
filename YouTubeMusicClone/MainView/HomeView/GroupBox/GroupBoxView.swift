//
//  GroupBoxView.swift
//  YouTubeMusicClone
//
//  Created by 김원기 on 12/15/23.
//

import SwiftUI
import Kingfisher

struct GroupBoxView: View {
    @ObservedObject var mainViewModel = MainViewModel()
    @ObservedObject var homeViewModel = HomeViewModel()
    @StateObject var groupBoxViewModel = GroupBoxViewModel()
    
    //@State var groupBoxInfo : GroupBoxInfo = GroupBoxInfo(id: "", thumbnailUrl: "", channelTitle: "", title: "", description: "")
    //@State var smallListInfo: [SmallListItemInfo] = []
    
    @Binding var userTokenOnGroupBoxView : String
    @State var id : String = "RDCLAK5uy_kVuz2Y7g6AUnbFdB2hLHo6EH8ieytGHbg" // For PlayList Thumbnail
    
    var body: some View {
        Group {
            VStack(alignment: .leading){
                HStack {
                    let url = URL(string: groupBoxViewModel.groupBoxInfo.thumbnailUrl)
                    KFImage(url)
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    VStack(alignment: .leading){
                        Text(groupBoxViewModel.groupBoxInfo.title)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                        Text(groupBoxViewModel.groupBoxInfo.channelTitle)
                            .font(.system(size: 13))
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.leading)
                        Text("\(groupBoxViewModel.groupBoxListSections.count) 곡")
                            .font(.system(size: 13))
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                
                Text(groupBoxViewModel.groupBoxInfo.description)
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 0))
                
                VStack() {
                    ForEach(0..<min(3,groupBoxViewModel.groupBoxListSections.count), id:\.self) { index in
                        homeViewModel.createSmallSizeCellInBox(smallListSections: $groupBoxViewModel.groupBoxListSections[index])
                    }
                }
                .padding((EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)))
                HStack(spacing: 30) {
                    Button {
                        // Play Button
                    } label: {
                        Image(systemName: "play.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .tint(.gray)
                    }
                    
                    Button {
                        // Play Button
                    } label: {
                        Image(systemName: "dot.radiowaves.left.and.right")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .tint(.gray)
                    }
                    
                    Button {
                        // Play Button
                    } label: {
                        
                        Image(systemName: "plus.square.on.square")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .tint(.gray)
                    }
                    
                    Spacer()
                }
                .padding((EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0)))
            }
        }
        .padding((EdgeInsets(top: -10, leading: -10, bottom: 10, trailing: -10)))
        .background(
            KFImage(URL(string: groupBoxViewModel.groupBoxInfo.thumbnailUrl))
                .resizable()
                .scaledToFill()
                .blur(radius: 20)
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear() {
            mainViewModel.callYouTubeApiForPlayList(accessToken: userTokenOnGroupBoxView, playListId: id) { result in
                switch result {
                case .success(let value):
                    mainViewModel.settingForPlayListInfo(value: value) { result in
                        switch result {
                        case .success(let data):
                            groupBoxViewModel.groupBoxInfo = data
                        case .failure(_):
                            print("error")
                        }
                    }
                case .failure(_):
                    print("error")
                }
            }
            mainViewModel.callYoutubeApi(accessToken: userTokenOnGroupBoxView, playListId: id) { result in
            switch result {
            case .success(let value):
                mainViewModel.settingForInfo(value: value) { result in
                    switch result {
                    case .success(let data):
                        groupBoxViewModel.groupBoxListSections = data
                    case .failure(_):
                        print("error")
                    }
                }
            case .failure(_):
                print("error")
            }
        }
        }
    }
}
