//
//  Factory.swift
//  NYTStories
//
//  Created by Hesham on 26/09/2022.
//

import Foundation

protocol Factory {
    func makeCoordinator() -> Coordinator
    func makeStoriesVC(storyDetailsCoordinator: StoryDetailsCoordinator) -> StoriesViewController
    func makeStoryDetailsVC(story: Story) -> StoryDetailsViewController
}
