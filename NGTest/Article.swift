//
//  Article.swift
//  NGTest
//

import Foundation

struct Article: Codable {

    let id: String
    let channelName: String
    let title: String
    let publicationDate: String

    private enum CodingKeys: String, CodingKey {
        case id
        case channelName
        case title
        case publicationDate
    }
}
