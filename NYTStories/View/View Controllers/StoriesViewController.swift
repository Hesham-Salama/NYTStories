//
//  StoriesViewController.swift
//  NYTStories
//
//  Created by Hesham on 24/09/2022.
//

import UIKit

class StoriesViewController: UIViewController {
    private var progressIndicator = UIActivityIndicatorView(frame: .zero)
    private var tableView = UITableView(frame: .zero)
    private var storiesViewModel: StoriesViewModel
    
    
    init(storiesViewModel: StoriesViewModel) {
        self.storiesViewModel = storiesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Please use the above initializer")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()
        navigationItem.title = "NYT Stories"
        setObservables()
        showLoading()
        storiesViewModel.finishedViewLoading()
    }
    
    func setObservables() {
        bindToStoriesObservable()
        bindToErrorMessageObservable()
    }
    
    private func bindToStoriesObservable() {
        storiesViewModel.storiesObservable.bind({ [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.showStories()
            }
        })
    }
    
    private func bindToErrorMessageObservable() {
        storiesViewModel.errorMessageObservable.bind({ [weak self] message in
            DispatchQueue.main.async {
                self?.showOKAlert(title: "Error", message: message ?? "no message")
                self?.showStories()
            }
        })
    }
    
    private func showLoading() {
        progressIndicator.isHidden = false
        progressIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    private func showStories() {
        progressIndicator.isHidden = true
        progressIndicator.stopAnimating()
        tableView.isHidden = false
    }
}

extension StoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storiesViewModel.storiesObservable.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.cellID, for: indexPath) as! StoryTableViewCell
        var story = storiesViewModel.storiesObservable.value[indexPath.row]
        cell.storyAuthorLabel.text = story.author
        cell.storyTitleLabel.text = story.title
        if let url = story.smallImageURL {
            cell.storyImageView.loadImage(at: url)
        }
        cell.timeAgoLabel.text = story.publishedDate?.timeAgoText ?? "some time ago"
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        storiesViewModel.storyRowClicked(index: indexPath.row)
    }
}


extension StoriesViewController: ViewCodeConfiguration {
    func buildHierarchy() {
        view.addSubview(progressIndicator)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        setTableViewConstraints()
        setupProgressIndicatorConstraints()
    }

    func configureViews() {
        configureView()
        configureTableView()
    }
    
    ///
    
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupProgressIndicatorConstraints() {
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        progressIndicator.centerYAnchor.constraint(equalTo:view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        progressIndicator.centerXAnchor.constraint(equalTo:view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StoryTableViewCell.self, forCellReuseIdentifier: StoryTableViewCell.cellID)
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
        }
    }
    
    private func configureView() {
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        }
    }
}
