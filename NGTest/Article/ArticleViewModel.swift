//
//  ArticleViewModel.swift
//  NGTest
//
//  Created by Anissa Bokhamy on 2026-01-20.
//  Copyright © 2026 Nuglif. All rights reserved.
//

import Foundation
import UIKit
import Combine

@MainActor
class ArticleViewModel: ObservableObject {

    @Published var channelName: String
    @Published var title: String
    @Published var publicationDateText: String
    @Published var modificationDateText: String?
    @Published var image: UIImage?
    @Published var content: String?

    private let imageDownloader: (String) async throws -> UIImage
    private let textDownloader: (String) async throws -> String

    private let imageURLString: String?
    private let contentURLString: String

    init(
        article: Article,
        imageDownloader: @escaping (String) async throws -> UIImage = { try await DataDownloader<UIImage>(dataConverter: { data in UIImage(data: data) }).downloadData(from: $0)},
        textDownloader: @escaping (String) async throws -> String = { try await DataDownloader<String>(dataConverter: { data in String(data: data, encoding: .utf8) }).downloadData(from: $0) }
    ) {
        channelName = article.channelName
        title = article.title
        publicationDateText = article.publicationDate
        modificationDateText = article.modificationDate
        imageURLString = article.imageUrl
        contentURLString = article.dataUrl
        self.imageDownloader = imageDownloader
        self.textDownloader = textDownloader
    }

    func loadImage() async {
        guard let imageURLString else { return }
        image = try? await imageDownloader(imageURLString)
    }

    func loadContent() async {
        content = try? await textDownloader(contentURLString)
    }
}
