//
//  StoryTableViewCell.swift
//  NYTStories
//
//  Created by Hesham on 27/09/2022.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
    static let cellID = "StoryTableViewCell"
    let storyImageView = UIImageView(frame: .zero)
    let storyTitleLabel = UILabel(frame: .zero)
    let storyAuthorLabel = UILabel(frame: .zero)
    let timeAgoLabel = UILabel(frame: .zero)

    
    override func prepareForReuse() {
        super.prepareForReuse()
        storyImageView.image = nil
        storyImageView.cancelImageLoad()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension StoryTableViewCell: ViewCodeConfiguration {
    func buildHierarchy() {
        self.contentView.addSubview(storyImageView)
        self.contentView.addSubview(storyTitleLabel)
        self.contentView.addSubview(storyAuthorLabel)
        self.contentView.addSubview(timeAgoLabel)
    }
    
    func setupConstraints() {
        setStoryImageViewConstraints()
        setStoryTitleLabelConstraints()
        setStoryAuthorLabelConstraints()
        setTimeAgoLabelConstraints()
    }
    
    func configureViews() {
        configureStoryImageView()
        configureStoryTitleLabel()
        configureStoryAuthorLabel()
        configureTimeAgoLabel()
    }
    
    ///
    
    private func setStoryImageViewConstraints() {
        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        storyImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        storyImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:8).isActive = true
        storyImageView.widthAnchor.constraint(equalToConstant:85).isActive = true
        storyImageView.heightAnchor.constraint(equalToConstant:85).isActive = true
    }
    
    private func setStoryTitleLabelConstraints() {
        storyTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        storyTitleLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:8).isActive = true
        storyTitleLabel.leadingAnchor.constraint(equalTo:storyImageView.trailingAnchor, constant:8).isActive = true
        storyTitleLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-8).isActive = true
    }
    
    private func setStoryAuthorLabelConstraints() {
        storyAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        storyAuthorLabel.topAnchor.constraint(equalTo:storyTitleLabel.bottomAnchor, constant:4).isActive = true
        storyAuthorLabel.leadingAnchor.constraint(equalTo:storyImageView.trailingAnchor, constant:8).isActive = true
        storyAuthorLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-8).isActive = true
    }
    
    private func setTimeAgoLabelConstraints() {
        timeAgoLabel.translatesAutoresizingMaskIntoConstraints = false
        timeAgoLabel.topAnchor.constraint(equalTo:storyAuthorLabel.bottomAnchor, constant:4).isActive = true
        timeAgoLabel.leadingAnchor.constraint(equalTo:storyImageView.trailingAnchor, constant:8).isActive = true
        timeAgoLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-8).isActive = true
        timeAgoLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    private func configureStoryImageView() {
        storyImageView.clipsToBounds = true
        storyImageView.contentMode = .scaleAspectFit
    }
    
    private func configureStoryTitleLabel() {
        storyTitleLabel.clipsToBounds = true
        storyTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        storyTitleLabel.numberOfLines = 3
    }
    
    private func configureStoryAuthorLabel() {
        storyAuthorLabel.clipsToBounds = true
        storyAuthorLabel.font = UIFont.systemFont(ofSize: 12)
        storyAuthorLabel.numberOfLines = 0
    }
    
    private func configureTimeAgoLabel() {
        timeAgoLabel.clipsToBounds = true
        timeAgoLabel.font = UIFont.systemFont(ofSize: 10)
    }
}
