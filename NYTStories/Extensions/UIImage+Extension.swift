//
//  UIImage+Extension.swift
//  NYTStories
//
//  Created by Hesham on 28/09/2022.
//

import UIKit

extension UIImageView {
    func loadImage(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
