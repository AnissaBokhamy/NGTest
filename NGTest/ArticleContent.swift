//
//  Root.swift
//  NGTest
//
//  Created by Anissa Bokhamy on 2026-01-20.
//  Copyright © 2026 Nuglif. All rights reserved.
//

import Foundation

struct Root: Codable {
    let data: ArticleData
}

struct ArticleData: Codable {
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct Item: Codable {
    let text: TextContent?

    enum CodingKeys: String, CodingKey {
        case text
    }
}

struct TextContent: Codable {
    let text: String?
}
