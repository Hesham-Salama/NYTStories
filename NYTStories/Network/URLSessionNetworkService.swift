//
//  URLSessionNetworkService.swift
//  NYTStories
//
//  Created by Hesham on 27/09/2022.
//

import Foundation

class URLSessionNetworkService {
    func getDataTask(request: URLRequest, completionHandler: @escaping (Result<Data, Error>) -> ()) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                if let nserror = error as NSError?, nserror.code == NSURLErrorCancelled {
                    completionHandler(.failure(ResponseError.cancelled))
                } else {
                    completionHandler(.failure(ResponseError.genericError))
                }
                return
            }
            
            guard let response = response else {
                completionHandler(.failure(ResponseError.noConnection))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                completionHandler(.failure(ResponseError.genericError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(ResponseError.invalidResponse))
                return
            }
            
            completionHandler(.success(data))
        }
    }
}

extension URLSessionNetworkService: NetworkService {
    func execute(request: URLRequest, completionHandler: @escaping (Result<Data, Error>) -> ()) {
        let task = getDataTask(request: request, completionHandler: completionHandler)
        task.resume()
    }
}
