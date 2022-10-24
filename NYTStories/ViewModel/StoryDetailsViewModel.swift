//
//  StoryDetailsViewModel.swift
//  NYTStories
//
//  Created by Hesham on 26/09/2022.
//

import Foundation

class StoryDetailsViewModel {
    var story: Story
    
    init(story: Story) {
        self.story = story
    }
    
    func seeMoreClicked(action: SeeMoreAction) {
        if let storyURL = story.url {
            action.browseUsingInternalSafari(url: storyURL)
        }
    }
}

protocol SeeMoreAction {
    func browseUsingInternalSafari(url: URL)
}
