//
//  MockStoriesRepository.swift
//  NYTStoriesTests
//
//  Created by Hesham on 27/09/2022.
//

import Foundation

class MockStoriesRepository {
    var mockContentData: Data?
    
    init() {
        mockContentData = getData(name: "mock")
    }

    private func getData(name: String, withExtension: String = "json") -> Data? {
        let fileUrl = Bundle.main.url(forResource: name, withExtension: withExtension)
        return try? Data(contentsOf: fileUrl!)
    }
}

extension MockStoriesRepository: StoriesRepository {
    func getStories(completionHandler: @escaping (Result<[Story], Error>) -> ()) {
        guard let data = mockContentData else {
            completionHandler(.failure(ResponseError.genericError))
            return
        }
        do {
            var storiesResult = try JSONDecoder().decode(StoriesResult.self, from: data)
            completionHandler(.success(storiesResult.articleStories))
        } catch let error {
            print(String(describing: error))
            completionHandler(.failure(ResponseError.decodingFailed))
        }
    }
}
