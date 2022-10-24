//
//  ResponseError.swift
//  NYTStories
//
//  Created by Hesham on 27/09/2022.
//

import Foundation

enum ResponseError: Error {
    case noConnection
    case genericError
    case invalidResponse
    case cancelled
    case decodingFailed
}
