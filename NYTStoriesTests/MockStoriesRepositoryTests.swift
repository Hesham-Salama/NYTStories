//
//  MockStoriesRepositoryTests.swift
//  NYTStoriesTests
//
//  Created by Hesham on 27/09/2022.
//

import XCTest
@testable import NYTStories

class MockStoriesRepositoryTests: XCTestCase {
    var mockRepo: MockStoriesRepository!
     
    override func setUp() {
        super.setUp()
        mockRepo = MockStoriesRepository()
    }
    
    override func tearDown() {
        super.tearDown()
        mockRepo = nil
    }
    
    func testNonNilData() {
        XCTAssert(mockRepo.mockContentData != nil, "Mock is nil")
    }
    
    func testStoriesContent() {
        mockRepo.getStories { result in
            switch result {
            case .success(var stories):
                XCTAssertEqual(stories.count, 30)
                XCTAssertEqual(stories[0].section, "world")
                XCTAssertEqual(stories[1].title, "4 Years After Thrilling Cave Rescue, Sleepy Park Readies for Onslaught")
                XCTAssertEqual(stories[2].author, "By Valerie Hopkins")
                XCTAssertEqual(stories[3].url?.absoluteString, "https://www.nytimes.com/2022/09/26/world/europe/italy-election-meloni-what-to-know.html")
                XCTAssertNotNil(stories[4].publishedDate)
            case .failure(let error):
                print(error)
                XCTFail("testStoriesContent - failed to decode: " + error.localizedDescription)
            }
        }
    }
}
