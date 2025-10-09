//
//  MainViewController.swift
//  NGTest

import UIKit

class MainViewController: UITableViewController {

    private var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "articles", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                articles = try decoder.decode([Article].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
        let item = articles[indexPath.row]
        cell.textLabel?.text = "[\(item.channelName)] \(item.title)"
        cell.detailTextLabel?.text = item.publicationDate
        return cell
    }
}

