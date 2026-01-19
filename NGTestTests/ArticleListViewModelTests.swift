//
//  JSONFileParserTests.swift
//  NGTest
//
//  Created by Anissa Bokhamy on 2026-01-19.
//  Copyright © 2026 Nuglif. All rights reserved.
//


import XCTest
@testable import NGTest

final class ArticleViewModelTests: XCTestCase {

    private var sut: ArticleListViewModel!

    override func setUp() {
        super.setUp()

        sut = ArticleListViewModel()
    }

    override func tearDown() {
        super.tearDown()

        sut = nil
    }

    func testSortByDateWithOrder_ascending() {
        // Given
        let article1 = Article(title: "A", publicationDate: "2026-01-08 13:16:40.000")
        let article2 = Article(title: "B", publicationDate: "2026-01-08 13:08:20.000")
        let article3 = Article(title: "C", publicationDate: "2026-01-08 13:25:00.000")

        sut.articles = [article1, article2, article3]

        // When
        sut.sortByDate(ascending: true)

        // Then
        let expectedArray = [article2, article1, article3]
        XCTAssertEqual(
            sut.articles,
            expectedArray,
            "Articles were not sorted in ascending order by publicationDate, found array '\(sut.articles)', expected '\(expectedArray)'"
        )
    }

    func testSortByDateWithOrder_descending() {
        // Given
        let article1 = Article(title: "A", publicationDate: "2026-01-08 13:16:40.000")
        let article2 = Article(title: "B", publicationDate: "2026-01-08 13:08:20.000")
        let article3 = Article(title: "C", publicationDate: "2026-01-08 13:25:00.000")


        sut.articles = [article1, article2, article3]

        // When
        sut.sortByDate(ascending: false)

        // Then
        let expectedArray = [article3, article1, article2]
        XCTAssertEqual(
            sut.articles,
            expectedArray,
            "Articles were not sorted in descending order by publicationDate, found array '\(sut.articles)', expected '\(expectedArray)'"
        )
    }

    func testSortByDateWithOrder_emptyArticles() {
        // Given
        sut.articles = []

        // When
        sut.sortByDate(ascending: true)

        // Then
        let expectedArray: [Article] = []
        XCTAssertEqual(
            sut.articles,
            expectedArray,
            "Sorting an empty articles array should leave it empty, found value (\(sut.articles)) instead."
        )
    }

    func testSortByDateWithOrder_singleArticle() {
        // Given
        let article = Article(title: "A", publicationDate: "2026-01-01 09:00:00.000")
        sut.articles = [article]

        // When
        sut.sortByDate(ascending: false)

        // Then
        let expectedArray = [article]
        XCTAssertEqual(
            sut.articles,
            [article],
            "Sorting a single-article array should not change the array, found array '\(sut.articles)', expected '\(expectedArray)'"
        )
    }

    func testSortByDateWithOrder_alreadySortedDoesNotChangeOrder() {
        // Given
        let article1 = Article(title: "A", publicationDate: "2026-01-01 09:00:00.000")
        let article2 = Article(title: "B", publicationDate: "2026-01-02 10:00:00.000")
        let article3 = Article(title: "C", publicationDate: "2026-01-03 11:00:00.000")
        let article4 = Article(title: "D", publicationDate: "2026-01-04 12:00:00.000")
        let article5 = Article(title: "E", publicationDate: "2026-01-05 13:00:00.000")
        sut.articles = [article1, article2, article3, article4, article5]

        // When
        sut.sortByDate(ascending: true)

        // Then
        let expectedArray = [article1, article2, article3, article4, article5]
        XCTAssertEqual(
            sut.articles,
            expectedArray,
            "Sorting a single-article array should not change the array, found array '\(sut.articles)', expected '\(expectedArray)'"
        )
    }

    func testSortByDateWithOrder_sameDateKeepsStableOrder() {
        // Given
        let article1 = Article(title: "A", publicationDate: "2026-01-08 13:15:57.000")
        let article2 = Article(title: "B", publicationDate: "2026-01-05 09:35:00.000")
        let article3 = Article(title: "C", publicationDate: "2026-01-10 18:45:12.000")
        let article4 = Article(title: "D", publicationDate: "2026-01-08 13:15:57.000")
        let article5 = Article(title: "E", publicationDate: "2026-01-05 09:30:00.000")
        sut.articles = [article1, article2, article3, article4, article5]

        // When
        sut.sortByDate(ascending: true)

        // Then
        let expectedArray = [article5, article2, article1, article4, article3]
        XCTAssertEqual(
            sut.articles,
            expectedArray,
            "Sorting a single-article array should not change the array, found array '\(sut.articles)', expected '\(expectedArray)'"
        )
    }

    func testSortByDate_firstSorting() {
        // Given
        let article1 = Article(title: "A", publicationDate: "2026-01-08 13:16:40.000")
        let article2 = Article(title: "B", publicationDate: "2026-01-08 13:08:20.000")
        let article3 = Article(title: "C", publicationDate: "2026-01-08 13:25:00.000")
        sut.articles = [article1, article2, article3]

        // When
        sut.sortByDate()

        // Then
        let expectedArray = [article2, article1, article3]
        XCTAssertEqual(
            sut.articles,
            expectedArray,
            "Default sort should sort articles in ascending order, found '\(sut.articles)', expected '\(expectedArray)'"
        )
    }

    func testSortByDate_sortingTwiceSortsDescending() {
        // Given
        let article1 = Article(title: "A", publicationDate: "2026-01-08 13:16:40.000")
        let article2 = Article(title: "B", publicationDate: "2026-01-08 13:08:20.000")
        let article3 = Article(title: "C", publicationDate: "2026-01-08 13:25:00.000")
        sut.articles = [article1, article2, article3]

        // When
        sut.sortByDate()  // first sort (ascending)
        sut.sortByDate()  // second sort (descending)


        // Then
        let expectedArray = [article3, article1, article2]
        XCTAssertEqual(
            sut.articles,
            expectedArray,
            "Sorting articles twice should sort articles in ascending order, found '\(sut.articles)', expected '\(expectedArray)'"
        )
    }

    func testSortByDate_sortingSevenTimesSortsAscending() {
        // Given
        let article1 = Article(title: "A", publicationDate: "2026-01-08 13:16:40.000")
        let article2 = Article(title: "B", publicationDate: "2026-01-08 13:08:20.000")
        let article3 = Article(title: "C", publicationDate: "2026-01-08 13:25:00.000")
        sut.articles = [article1, article2, article3]

        // When
        
        sut.sortByDate()  // first sort (ascending)
        sut.sortByDate()  // second sort (descending)
        sut.sortByDate()  // third sort (ascending)
        sut.sortByDate()  // fourth sort (descending)
        sut.sortByDate()  // fifth sort (ascending)
        sut.sortByDate()  // sixth sort (descending)
        sut.sortByDate()  // seventh sort (ascending)


        // Then
        let expectedArray = [article2, article1, article3]
        XCTAssertEqual(
            sut.articles,
            expectedArray,
            "Sorting articles seven times should sort articles in ascending order, found '\(sut.articles)', expected '\(expectedArray)'"
        )
    }

    func testSortByDate_emptyArticles() {
        // Given
        sut.articles = []

        // When
        sut.sortByDate()

        // Then
        let expectedArray: [Article] = []
        XCTAssertEqual(
            sut.articles,
            expectedArray,
            "Sorting an empty articles array should leave it empty, found value (\(sut.articles)) instead."
        )
    }

    func testSortByDate_singleArticle() {
        // Given
        let article1 = Article(title: "A", publicationDate: "2026-01-08 13:16:40.000")
        sut.articles = [article1]

        // When
        sut.sortByDate()

        // Then
        let expectedArray = [article1]
        XCTAssertEqual(
            sut.articles,
            expectedArray,
            "Sorting a single-article array should not change the array, found array '\(sut.articles)', expected '\(expectedArray)'"
        )
    }
}


fileprivate extension Article {
    init(title: String, publicationDate: String) {
        self = Article(id: UUID().uuidString, channelName: "Test Channel", title: title, publicationDate: publicationDate)
    }
}
