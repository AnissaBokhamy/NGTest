//
//  JSONFileParser.swift
//  NGTest
//
//  Created by Anissa Bokhamy on 2026-01-19.
//  Copyright © 2026 Nuglif. All rights reserved.
//

import Foundation
import Combine

enum JSONParsingError: Error {
    case fileNotFound
}

struct JSONFileParser<T> where T: Codable {

    var fileName: String

    func data(
        pathCreator: @escaping((String) -> String?) = { Bundle.main.path(forResource: $0, ofType: "json") },
        urlBuilder: @escaping((String) -> URL) = { URL(fileURLWithPath: $0) }
    ) throws -> Data {
        guard let filePath = pathCreator(fileName) else {
            throw JSONParsingError.fileNotFound
        }
        let fileURL = urlBuilder(filePath)
        return try Data(contentsOf: fileURL, options: .mappedIfSafe)
    }

    func decodeJSON(
        pathCreator: @escaping((String) -> String?) = { Bundle.main.path(forResource: $0, ofType: "json") },
        urlBuilder: @escaping((String) -> URL) = { URL(fileURLWithPath: $0) },
        fileDecoder: JSONDecoder = JSONDecoder()
    ) throws -> T {
        let dataFromJSON = try data(pathCreator: pathCreator, urlBuilder: urlBuilder)
        return try fileDecoder.decode(T.self, from: dataFromJSON)
    }
}
