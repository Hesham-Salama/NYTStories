//
//  StoriesViewModel.swift
//  NYTStories
//
//  Created by Hesham on 26/09/2022.
//

import Foundation

class StoriesViewModel {
    private var coordinator: StoryDetailsCoordinator?
    private let storiesRepository: StoriesRepository
    private(set) var errorMessageObservable: Observable<String?> = Observable(nil)
    private(set) var storiesObservable: Observable<[Story]> = Observable([])
    
    init(storiesRepository: StoriesRepository, coordinator: StoryDetailsCoordinator? = nil) {
        self.coordinator = coordinator
        self.storiesRepository = storiesRepository
    }
    
    func finishedViewLoading() {
        getStories()
    }
    
    // not private for testing purposes
    func getStories() {
        storiesRepository.getStories { [weak self] result in
            switch result {
            case .success(let stories):
                self?.storiesObservable.value = stories
            case .failure(let error):
                self?.errorMessageObservable.value = error.localizedDescription
            }
        }
    }
    
    func storyRowClicked(index: Int) {
        coordinator?.navigateToStoryDetails(story: storiesObservable.value[index])
    }
}
