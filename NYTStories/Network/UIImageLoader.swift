//
//  UIImageLoader.swift
//  NYTStories
//
//  Created by Hesham on 27/09/2022.
//

import Foundation
import UIKit

class UIImageLoader {
    private let imageLoader: ImageLoader

    static let loader = UIImageLoader()
    private var uuidMap = [UIImageView: UUID]()
    
    private init() {
        self.imageLoader = URLSessionImageLoader()
    }
    
    func load(_ url: URL, for imageView: UIImageView) {
        let token = imageLoader.loadImage(url) { result in
            defer { self.uuidMap.removeValue(forKey: imageView) }
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}


private class URLSessionImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    private let urlSessionNetwokService = URLSessionNetworkService()


    private func getImageDataTask(url: URL, uuid: UUID, completion: @escaping (Result<UIImage, Error>) -> Void) -> URLSessionDataTask {
        return urlSessionNetwokService.getDataTask(request: URLRequest(url: url)) { result in
            defer {self.runningRequests.removeValue(forKey: uuid) }
            switch result {
                
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(ResponseError.invalidResponse))
                    return
                }
                self.loadedImages[url] = image
                completion(.success(image))
            case .failure(let error):
                guard let responseError = error as? ResponseError, responseError == .cancelled else {
                    completion(.failure(error))
                    return
                }
            }
        }
    }
}

extension URLSessionImageLoader: ImageLoader {
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        
        let uuid = UUID()
        let task = getImageDataTask(url: url, uuid: uuid, completion: completion)
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}

private protocol ImageLoader {
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    func cancelLoad(_ uuid: UUID)
}
