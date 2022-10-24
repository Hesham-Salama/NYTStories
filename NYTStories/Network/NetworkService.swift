//
//  NetworkService.swift
//  NYTStories
//
//  Created by Hesham on 27/09/2022.
//

import Foundation

protocol NetworkService {
    func execute(request: URLRequest, completionHandler: @escaping (Result<Data, Error>) -> ())
}
