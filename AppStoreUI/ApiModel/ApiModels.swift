//
//  ApiModels.swift
//  AppStoreUI
//
//  Created by Jackson Pitcher on 12/26/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import UIKit

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
        let trackId: Int
        let trackName: String
        let primaryGenreName: String
        var averageUserRating: Float?
        var screenshotUrls: [String]?
        let artworkUrl100: String // app icon
        var formattedPrice: String?
        var description: String?
        var releaseNotes: String?
        var artistName: String?
        var collectionName: String?
}

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let id: String
    let name: String
    let artistName: String
    let artworkUrl100: String
}

struct SocialApp: Decodable {
    let id: String
    let name: String
    let imageUrl: String
    let tagline: String
}


//App reviews api model below

struct Reviews: Decodable {
    let feed: ReviewFeed
    
}

struct ReviewFeed: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let author: Author
    let title: Label
    let content: Label
    let rating: Label
    
    private enum CodingKeys: String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}

struct Author: Decodable {
    let name: Label
}

struct Label: Decodable {
    let label: String
}

//api models for today view

struct TodayItem {
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    let cellType: CellType
    
    let apps: [FeedResult]
    
    enum CellType: String {
        case single, multiple
    }
}


