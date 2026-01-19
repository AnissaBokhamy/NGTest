//
//  ArticleListViewModel.swift
//  NGTest
//
//  Created by Anissa Bokhamy on 2026-01-19.
//  Copyright © 2026 Nuglif. All rights reserved.
//

import Foundation

class ArticleListViewModel: ObservableObject {

    private static let articlesJsonFileName = "articles"
    private static let articlesJsonParser = JSONFileParser<[Article]>(fileName: articlesJsonFileName)


    @Published var articles: [Article] = []

    func loadArticles(decodeArticles: @escaping(() throws -> [Article]) = { try articlesJsonParser.decodeJSON() }) {
        guard let loadedArticles = try? decodeArticles() else { return }
        articles = loadedArticles
    }

    func sortByDate(ascending: Bool) {
        articles.sort { (lhs: Article, rhs: Article) -> Bool in
            if ascending {
                return lhs.publicationDate < rhs.publicationDate
            } else {
                return lhs.publicationDate > rhs.publicationDate
            }
        }
    }
}
