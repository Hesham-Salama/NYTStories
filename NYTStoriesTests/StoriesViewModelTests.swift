//
//  StoriesViewModelTests.swift
//  NYTStoriesTests
//
//  Created by Hesham on 29/09/2022.
//

import XCTest
@testable import NYTStories

class StoriesViewModelTests: XCTestCase {
    var viewModel: StoriesViewModel!
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testGettingStories() {
        viewModel = StoriesViewModel(storiesRepository: MockStoriesRepository())
        viewModel.getStories()
        XCTAssertEqual(viewModel.storiesObservable.value.count, 30)
    }
    
    func testErrorMessageSet() {
        let repo = MockStoriesRepository()
        repo.mockContentData = nil
        viewModel = StoriesViewModel(storiesRepository: repo)
        viewModel.getStories()
        XCTAssertNotNil(viewModel.errorMessageObservable.value)
    }
}
