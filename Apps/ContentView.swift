//
//  ContentView.swift
//  Apps
//
//  Created by 이지원 on 2021/01/03.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @ObservedObject var viewModel = AppsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(minimum: 100, maximum: 200), spacing: 16, alignment: .top),
                        GridItem(.flexible(minimum: 100, maximum: 200), spacing: 16, alignment: .top),
                        GridItem(.flexible(minimum: 100, maximum: 200), alignment: .top)
                    ],
                    alignment: .leading,
                    spacing: 8,
                    content: {
                        ForEach(viewModel.feedResults, id: \.self) { feedResult in
                            FeedResultView(feedResult: feedResult)
                        }
                    }
                ).padding(.horizontal, 16)
            }.navigationTitle("Search")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FeedResultView: View {
    
    let feedResult: FeedResult
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            KFImage(URL(string: feedResult.artworkUrl100))
                .resizable()
                .scaledToFit()
                .cornerRadius(18)
                .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.gray, lineWidth: 0.25))

            
            Text(feedResult.name)
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 4)
                .padding(.top, 4)
            
            Text(feedResult.releaseDate)
                .font(.system(size: 10, weight: .regular))
                .padding(.horizontal, 4)
            
            Text(feedResult.copyright ?? "")
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(.gray)
                .padding(.horizontal, 4)
            
            Spacer()
        }
    }
}
