//
//  AppsViewModel.swift
//  Apps
//
//  Created by 이지원 on 2021/01/03.
//

import Foundation

class AppsViewModel: ObservableObject {
    
    @Published var feedResults = [FeedResult]()
    
    init() {
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/kr/ios-apps/top-free/all/100/explicit.json") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else { return }
                let rss = try JSONDecoder().decode(RSS.self, from: data)
                self.feedResults = rss.feed.results
            } catch {
                print("failed to decode \(error)")
            }
        }.resume()
    }
}

struct RSS: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [FeedResult]
}

struct FeedResult: Decodable, Hashable {
    let releaseDate, name, artworkUrl100: String
    let copyright: String?
}
