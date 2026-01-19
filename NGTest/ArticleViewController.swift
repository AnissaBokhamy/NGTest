//
//  ArticleViewController
//  NGTest
//
//  Created by Anissa Bokhamy on 2026-01-12.
//  Copyright © 2026 Nuglif. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    // MARK: - Properties

    @MainActor var article: Article? {
        didSet {
            updateView()
        }
    }

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
        
        
    }

    // MARK: - Methods

    private func updateView() {

    }
}
