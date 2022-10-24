//
//  ViewCodeConfiguration.swift
//  NYTStories
//
//  Created by Hesham on 24/09/2022.
//

import Foundation

protocol ViewCodeConfiguration {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeConfiguration {
    func configureViews() {}
    
    func applyViewCode() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
