//
//  MainViewController.swift
//  NGTest

import UIKit

class MainViewController: UITableViewController {

    private var viewModel = ArticleListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadArticles()
        tableView.reloadData()
    }

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
    
}

