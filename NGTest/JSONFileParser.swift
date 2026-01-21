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

enum JSONFileInputType {
    case localFileName
    case remoteURLString

    static func fileURL(for inputType: JSONFileInputType, input: String) -> URL? {
        switch inputType {
        case .localFileName:
            guard let filePath = Bundle.main.path(forResource: input, ofType: "json") else { return nil }
            return URL(fileURLWithPath: filePath)
        case .remoteURLString:
            return URL(string: input)
        }
    }
}

struct JSONFileParser<T> where T: Codable {

    var fileInputString: String
    var inputType: JSONFileInputType = .localFileName

    func data(
        urlBuilder: @escaping((JSONFileInputType, String) -> URL?) = { JSONFileInputType.fileURL(for: $0, input: $1)},
    ) throws -> Data {
        guard let fileURL = urlBuilder(inputType, fileInputString) else {
            throw JSONParsingError.fileNotFound
        }

        return try Data(contentsOf: fileURL, options: .mappedIfSafe)
    }

    func decodeJSON(
        pathCreator: @escaping((String) -> String?) = { Bundle.main.path(forResource: $0, ofType: "json") },
        urlBuilder: @escaping((JSONFileInputType, String) -> URL?) = { JSONFileInputType.fileURL(for: $0, input: $1)},
        fileDecoder: JSONDecoder = JSONDecoder()
    ) throws -> T {
        let dataFromJSON = try data(urlBuilder: urlBuilder)
        return try fileDecoder.decode(T.self, from: dataFromJSON)
    }
}
