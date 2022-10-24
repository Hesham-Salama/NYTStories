//
//  Story.swift
//  NYTStories
//
//  Created by Hesham on 26/09/2022.
//

import Foundation

struct StoriesResult: Codable {
    private let results: [Story]
    
    lazy var articleStories: [Story] = {
        results.filter { $0.type == .article }
    }()
}

struct Story: Codable {
    let section, subsection, title, abstract: String
    private let link: String
    let author: String
    let type: StoryType
    private let publishedDateStr: String
    private let multimedia: [Multimedia]
    
    lazy var smallImageURL: URL? = {
        return getImageURL(format: .smallImage)
    }()
    
    lazy var mediumImageURL: URL? = {
        return getImageURL(format: .mediumImage)
    }()
    
    lazy var largeImageURL: URL? = {
        return getImageURL(format: .largeImage)
    }()
    
    lazy var publishedDate: Date? = {
        return Formatter.iso8601.date(from: publishedDateStr)
    }()
    
    lazy var url: URL? = {
       return URL(string: link)
    }()

    enum CodingKeys: String, CodingKey {
        case section, subsection, title, abstract
        case author = "byline"
        case type = "item_type"
        case publishedDateStr = "published_date"
        case multimedia
        case link = "url"
    }
    
    enum StoryType: String, Codable {
        case article = "Article"
        case promo = "Promo"
        case interactive = "Interactive"
    }
    
    private func getImageURL(format: Multimedia.Format) -> URL? {
        if let link = (multimedia.filter { $0.format == format }).first?.link {
            return URL(string: link)
        }
        return nil
    }
}

struct Multimedia: Codable {
    let link: String
    let format: Format
    
    enum CodingKeys: String, CodingKey {
        case link = "url"
        case format
    }
    
    enum Format: String, Codable {
        case mediumImage = "Large Thumbnail"
        case largeImage = "Super Jumbo"
        case smallImage = "threeByTwoSmallAt2X"
    }

    enum MultimediaType: String, Codable {
        case image = "image"
    }
}
