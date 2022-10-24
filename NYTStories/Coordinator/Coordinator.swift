//
//  Coordinator.swift
//  NYTStories
//
//  Created by Hesham on 26/09/2022.
//

import Foundation
import UIKit

protocol StoryDetailsCoordinator {
    func navigateToStoryDetails(story: Story)
}

class Coordinator {
    private let factory: Factory
    // weak because navigation controller has indirect cycle with the coordinator
    // nav -> stories vc -> view model -> coordinator -> factory -> nav
    private weak var navigationController: UINavigationController?
    
    init(factory: Factory) {
        self.factory = factory
    }

    func start(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        let storiesVC = factory.makeStoriesVC(storyDetailsCoordinator: self)
        self.navigationController?.pushViewController(storiesVC, animated: true)
    }
}

extension Coordinator: StoryDetailsCoordinator {
    func navigateToStoryDetails(story: Story) {
        let storyDetailsVC = factory.makeStoryDetailsVC(story: story)
        navigationController?.pushViewController(storyDetailsVC, animated: true)
    }
}
