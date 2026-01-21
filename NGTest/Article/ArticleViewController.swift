//
//  ArticleViewController
//  NGTest
//
//  Created by Anissa Bokhamy on 2026-01-12.
//  Copyright © 2026 Nuglif. All rights reserved.
//

import UIKit
import Combine

class ArticleViewController: UIViewController {

    // MARK: - Properties

    @MainActor var viewModel: ArticleViewModel?

    private var cancellables: Set<AnyCancellable> = []

    // MARK: Views

    @IBOutlet private weak var channelLabel: UILabel!
    @IBOutlet private weak var publicationDateLabel: UILabel!
    @IBOutlet private weak var modificationDateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var contentTextView: UITextView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        launchDownloads()
    }

    private func launchDownloads() {
        Task { [weak self] in
            await self?.viewModel?.loadImage()
        }
        Task { [weak self] in
            await self?.viewModel?.loadContent()
        }
    }

    // MARK: - Binding

    private func bindViewModel() {
        viewModel?.$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.updateImageView() }
            .store(in: &cancellables)

        viewModel?.$channelName
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.updateChannelLabel() }
            .store(in: &cancellables)

        viewModel?.$publicationDateText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.updatePublicationDateLabel() }
            .store(in: &cancellables)

        viewModel?.$modificationDateText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.updateModificationDateLabel() }
            .store(in: &cancellables)

        viewModel?.$title
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.updateTitleLabel() }
            .store(in: &cancellables)

        viewModel?.$content
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.updateContentTextView() }
            .store(in: &cancellables)
    }

    // MARK: - UI Updates

    private func updateImageView() {
        imageView.image = viewModel?.image
        imageView.isHidden = viewModel?.image == nil
    }

    private func updateChannelLabel() {
        // Hide the label when the view model's value is nil
        if let channel = viewModel?.channelName {
            channelLabel.text = channel
            channelLabel.isHidden = false
        } else {
            channelLabel.isHidden = true
        }
    }

    private func updatePublicationDateLabel() {
        if let publicationDate = viewModel?.publicationDateText {
            publicationDateLabel.text = publicationDate
            publicationDateLabel.isHidden = false
        } else {
            publicationDateLabel.isHidden = true
        }
    }

    private func updateModificationDateLabel() {
        if let modificationDate = viewModel?.modificationDateText {
            modificationDateLabel.text = modificationDate
            modificationDateLabel.isHidden = false
        } else {
            modificationDateLabel.isHidden = true
        }
    }

    private func updateTitleLabel() {
        if let title = viewModel?.title {
            titleLabel.text = title
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
        }
    }

    private func updateContentTextView() {
        if let content = viewModel?.content {
            contentTextView.text = content
            contentTextView.isHidden = false
        } else {
            contentTextView.text = nil
            contentTextView.isHidden = true
        }
    }
}
