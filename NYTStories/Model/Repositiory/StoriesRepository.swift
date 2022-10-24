//
//  StoriesRepository.swift
//  NYTStories
//
//  Created by Hesham on 26/09/2022.
//

import Foundation

protocol StoriesRepository {
    func getStories(completionHandler: @escaping (Result<[Story], Error>) -> ())
}
