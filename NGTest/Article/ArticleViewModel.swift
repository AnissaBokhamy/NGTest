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
    private let contentDecoder: (String) async throws -> Root

    private let imageURLString: String?
    private let contentURLString: String

    init(
        article: Article,
        imageDownloader: @escaping (String) async throws -> UIImage = { try await DataDownloader<UIImage>(dataConverter: { data in UIImage(data: data) }).downloadData(from: $0)},
        contentDecoder: @escaping (String) async throws -> Root =  { try JSONFileParser<Root>(fileInputString: $0, inputType: .remoteURLString).decodeJSON() }
    ) {
        channelName = article.channelName
        title = article.title
        publicationDateText = article.publicationDate
        modificationDateText = article.modificationDate
        imageURLString = article.imageUrl
        contentURLString = article.dataUrl
        self.imageDownloader = imageDownloader
        self.contentDecoder = contentDecoder
    }

    func loadImage() async {
        guard let imageURLString else { return }
        image = try? await imageDownloader(imageURLString)
    }

    func loadContent() async {
        let textFound = try? await contentDecoder(contentURLString)
        content = textFound?.text
    }
}

extension Root {
    var text: String? {
        data.items?.compactMap(\.text?.text).joined(separator: "\n")
    }
}
