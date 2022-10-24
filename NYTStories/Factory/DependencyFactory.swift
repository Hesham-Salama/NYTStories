//
//  DependencyFactory.swift
//  NYTStories
//
//  Created by Hesham on 26/09/2022.
//

import Foundation

class DependencyFactory {
    private func getOnlineStoriesRepositiory() -> OnlineStoriesRepository {
        let networkService = URLSessionNetworkService()
        return OnlineStoriesRepository(networkService: networkService)
    }
    
    private func getStoryDetailsViewModel(story: Story) -> StoryDetailsViewModel {
        return StoryDetailsViewModel(story: story)
    }
    
    private func getStoriesViewModel(coordinator: StoryDetailsCoordinator) -> StoriesViewModel {
        let storiesRepository = getOnlineStoriesRepositiory()
        return StoriesViewModel(storiesRepository: storiesRepository, coordinator: coordinator)
    }
}

extension DependencyFactory: Factory {
    func makeCoordinator() -> Coordinator {
        return Coordinator(factory: self)
    }

    func makeStoriesVC(storyDetailsCoordinator: StoryDetailsCoordinator) -> StoriesViewController {
        let storiesViewModel = getStoriesViewModel(coordinator: storyDetailsCoordinator)
        return StoriesViewController(storiesViewModel: storiesViewModel)
    }
    
    func makeStoryDetailsVC(story: Story) -> StoryDetailsViewController {
        let storyDetailsViewModel = getStoryDetailsViewModel(story: story)
        return StoryDetailsViewController(storyDetailsViewModel: storyDetailsViewModel)
    }
}
