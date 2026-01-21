//
//  Article.swift
//  NGTest
//

import Foundation

struct Article: Codable, Equatable {

    let id: String
    let channelName: String
    let title: String
    let publicationDate: String
    let modificationDate: String?
    let dataUrl: String
    private let visual: [VisualItem]?

    var imageUrl: String? {
        visual?.first?.urlPattern
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case channelName
        case title
        case publicationDate
        case modificationDate
        case dataUrl
        case visual
    }
}

private struct VisualItem: Codable, Equatable {
    let id: String
    let className: String
    let urlPattern: String
}


