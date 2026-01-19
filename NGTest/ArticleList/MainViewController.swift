//
//  MainViewController.swift
//  NGTest

import UIKit
import Combine

class MainViewController: UITableViewController {

    // MARK: - Properties

    private var viewModel = ArticleListViewModel()
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.$articles
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.loadArticles()
    }

    // MARK: - TableViewDelegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
        let item = viewModel.articles[indexPath.row]
        cell.textLabel?.text = "[\(item.channelName)] \(item.title)"
        cell.detailTextLabel?.text = item.publicationDate
        return cell
    }

    // MARK: - Navigation

    @IBSegueAction func presentArticleViewController(_ coder: NSCoder) -> ArticleViewController? {
        let articleViewController = ArticleViewController(coder: coder)

        guard let selectedArticle = tableView.indexPathForSelectedRow?.row else { return nil }
        articleViewController?.article = viewModel.articles[selectedArticle]
        return articleViewController
    }
    
    @IBAction func onSortButtonTap(_ sender: Any) {
        viewModel.sortByDate(ascending: true)
    }
}

