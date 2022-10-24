//
//  StoryURLRequest.swift
//  NYTStories
//
//  Created by Hesham on 27/09/2022.
//

import Foundation

class StoryURLRequest {
    private static let token = "D0R9aGv15WRyKvYGwV8iEDBLcUXTnTbl"
    private static let hostName = "api.nytimes.com"
    private static let defaultTimeoutInSeconds: TimeInterval = 30
    
    private enum StoriesTypePath: String {
        case topStories = "/svc/topstories/v2/world.json"
    }
    
    var topStories: URLRequest {
        let url = getURL(type: .topStories)
        return getDefaultGETRequest(url)
    }
    
    private func getURL(type: StoriesTypePath) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = StoryURLRequest.hostName
        components.path = type.rawValue
        let queryItemToken = URLQueryItem(name: "api-key", value: StoryURLRequest.token)
        components.queryItems = [queryItemToken]
        return components.url!
    }
    
    private func getDefaultGETRequest(_ url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: StoryURLRequest.defaultTimeoutInSeconds)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
}
