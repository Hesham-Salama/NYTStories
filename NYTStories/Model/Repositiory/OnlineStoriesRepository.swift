//
//  OnlineStoriesRepository.swift
//  NYTStories
//
//  Created by Hesham on 26/09/2022.
//

import Foundation

class OnlineStoriesRepository {
    private let storyURLRequest: StoryURLRequest
    private let networkService: NetworkService
    private let decoder: JSONDecoder
    
    init(networkService: NetworkService) {
        self.storyURLRequest = StoryURLRequest()
        self.networkService = networkService
        self.decoder = JSONDecoder()
    }
    
    private func decode(data: Data) -> [Story]? {
        do {
            var result = try decoder.decode(StoriesResult.self, from: data)
            return result.articleStories
        } catch let error {
            print(error)
            return nil
        }
    }
}

extension OnlineStoriesRepository: StoriesRepository {
    func getStories(completionHandler: @escaping (Result<[Story], Error>) -> ()) {
        let urlRequest = storyURLRequest.topStories
        networkService.execute(request: urlRequest) { [weak self] result in
            switch result {
            case .success(let data):
                guard let stories = self?.decode(data: data) else {
                    completionHandler(.failure(ResponseError.decodingFailed))
                    return
                }
                completionHandler(.success(stories))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
