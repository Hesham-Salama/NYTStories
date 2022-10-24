//
//  StoryDetailsViewController.swift
//  NYTStories
//
//  Created by Hesham on 26/09/2022.
//

import UIKit
import SafariServices

class StoryDetailsViewController: UIViewController {
    private let storyImageView = UIImageView(frame: .zero)
    private let storyTitleLabel = UILabel(frame: .zero)
    private let storyAuthorLabel = UILabel(frame: .zero)
    private let timeAgoLabel = UILabel(frame: .zero)
    private let storyDescriptionLabel = UILabel(frame: .zero)
    private let seeMoreButton = UIButton(frame: .zero)
    private let scrollView = UIScrollView(frame: .zero)
    private let containerView = UIView(frame: .zero)

    private var storyDetailsViewModel: StoryDetailsViewModel

    init(storyDetailsViewModel: StoryDetailsViewModel) {
        self.storyDetailsViewModel = storyDetailsViewModel
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("Please use the above initializer")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()
        setStoryViewsWithValues()
    }
    
    func setStoryViewsWithValues() {
        var story = storyDetailsViewModel.story
        navigationItem.title = ([story.section, story.subsection].filter { !$0.isEmpty }).joined(separator: " - ")
        if let largeImageURL = story.largeImageURL {
            storyImageView.loadImage(at: largeImageURL)
        }
        storyTitleLabel.text = story.title
        storyAuthorLabel.text = story.author
        timeAgoLabel.text = story.publishedDate?.timeAgoText ?? "some time ago"
        storyDescriptionLabel.text = story.abstract
        seeMoreButton.setTitle("See more...", for: .normal)
        seeMoreButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(sender : UIButton) {
        storyDetailsViewModel.seeMoreClicked(action: self)
    }
}

extension StoryDetailsViewController: SeeMoreAction {
    func browseUsingInternalSafari(url: URL) {
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}

extension StoryDetailsViewController: ViewCodeConfiguration {
    func buildHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(storyImageView)
        containerView.addSubview(storyTitleLabel)
        containerView.addSubview(storyAuthorLabel)
        containerView.addSubview(timeAgoLabel)
        containerView.addSubview(storyDescriptionLabel)
        containerView.addSubview(seeMoreButton)
    }
    
    func setupConstraints() {
        setScrollViewConstraints()
        setContainerViewConstraints()
        setStoryImageViewConstraints()
        setStoryTitleLabelConstraints()
        setStoryAuthorLabelConstraints()
        setTimeAgoLabelConstraints()
        setStoryDescriptionLabelConstraints()
        setSeeMoreButtonConstraints()
    }
    
    func configureViews() {
        configureView()
        configureStoryImageView()
        configureStoryTitleLabel()
        configureStoryAuthorLabel()
        configureTimeAgoLabel()
        configureStoryDescriptionLabel()
        configureSeeMoreButton()
    }
    
    ///
    
    private func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo:scrollView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo:scrollView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo:scrollView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
    }
    
    private func setStoryImageViewConstraints() {
        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        storyImageView.topAnchor.constraint(equalTo:containerView.topAnchor, constant:16).isActive = true
        storyImageView.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant:16).isActive = true
        storyImageView.trailingAnchor.constraint(equalTo:containerView.trailingAnchor, constant:-16).isActive = true
        storyImageView.heightAnchor.constraint(equalToConstant:300).isActive = true
    }
    
    private func setStoryTitleLabelConstraints() {
        storyTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        storyTitleLabel.topAnchor.constraint(equalTo:storyImageView.bottomAnchor, constant:16).isActive = true
        storyTitleLabel.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant:16).isActive = true
        storyTitleLabel.trailingAnchor.constraint(equalTo:containerView.trailingAnchor, constant:-16).isActive = true
    }
    
    private func setStoryAuthorLabelConstraints() {
        storyAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        storyAuthorLabel.topAnchor.constraint(equalTo:storyTitleLabel.bottomAnchor, constant:8).isActive = true
        storyAuthorLabel.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant:16).isActive = true
        storyAuthorLabel.trailingAnchor.constraint(equalTo:containerView.trailingAnchor, constant:-16).isActive = true
    }
    
    private func setTimeAgoLabelConstraints() {
        timeAgoLabel.translatesAutoresizingMaskIntoConstraints = false
        timeAgoLabel.topAnchor.constraint(equalTo:storyAuthorLabel.bottomAnchor, constant:8).isActive = true
        timeAgoLabel.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant:16).isActive = true
        timeAgoLabel.trailingAnchor.constraint(equalTo:containerView.trailingAnchor, constant:-16).isActive = true
    }
    
    private func setStoryDescriptionLabelConstraints() {
        storyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        storyDescriptionLabel.topAnchor.constraint(equalTo:timeAgoLabel.bottomAnchor, constant:8).isActive = true
        storyDescriptionLabel.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant:16).isActive = true
        storyDescriptionLabel.trailingAnchor.constraint(equalTo:containerView.trailingAnchor, constant:-16).isActive = true
    }
    
    private func setSeeMoreButtonConstraints() {
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        seeMoreButton.topAnchor.constraint(equalTo:storyDescriptionLabel.bottomAnchor, constant:8).isActive = true
        seeMoreButton.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant:16).isActive = true
        seeMoreButton.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -8).isActive = true
    }
    
    private func configureView() {
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        }
    }
    
    private func configureStoryImageView() {
        storyImageView.clipsToBounds = true
        storyImageView.contentMode = .scaleAspectFill
    }
    
    private func configureStoryTitleLabel() {
        storyTitleLabel.clipsToBounds = true
        storyTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        storyTitleLabel.numberOfLines = 0
    }
    
    
    private func configureStoryAuthorLabel() {
        storyAuthorLabel.clipsToBounds = true
        storyAuthorLabel.font = UIFont.systemFont(ofSize: 14)
        storyAuthorLabel.numberOfLines = 3
    }
    
    private func configureTimeAgoLabel() {
        timeAgoLabel.clipsToBounds = true
        timeAgoLabel.font = UIFont.systemFont(ofSize: 12)
        timeAgoLabel.numberOfLines = 1
    }
    
    private func configureStoryDescriptionLabel() {
        storyDescriptionLabel.clipsToBounds = true
        storyDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        storyDescriptionLabel.numberOfLines = 0
    }
    
    private func configureSeeMoreButton() {
        seeMoreButton.clipsToBounds = true
        seeMoreButton.setTitleColor(.blue, for: .normal)
        seeMoreButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
}
