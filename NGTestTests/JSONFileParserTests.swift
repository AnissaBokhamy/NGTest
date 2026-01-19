//
//  JSONFileParserTests.swift
//  NGTest
//
//  Created by Anissa Bokhamy on 2026-01-19.
//  Copyright © 2026 Nuglif. All rights reserved.
//


import XCTest
@testable import NGTest

final class JSONFileParserTests: XCTestCase {

    // MARK: - Helpers

    private func writeMockJSON(
        fileName: String,
        jsonString: String
    ) throws -> URL {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(fileName)
            .appendingPathExtension("json")

        try jsonString
            .data(using: .utf8)!
            .write(to: url, options: .atomic)

        return url
    }

    // MARK: - Tests

    func testDecodeJSON_multipleElements() throws {
        // Given: JSON with 3 elements
        let json = """
        [
            {"id": 1, "name": "Alice", "isActive": true, "score": 95.5, "tags": ["swift","ios","unit-test"]},
            {"id": 2, "name": "Bob", "isActive": false, "score": 80.0, "tags": ["backend","api"]},
            {"id": 3, "name": "Charlie", "isActive": true, "score": 70.25, "tags": ["design","ux"]}
        ]
        """

        let fileURL = try writeMockJSON(
            fileName: "multiple_elements",
            jsonString: json
        )

        let sut = JSONFileParser<[FakeModel]>(
            fileName: "multiple_elements"
        )

        let expectedModels = [
            FakeModel(id: 1, name: "Alice", isActive: true, score: 95.5, tags: ["swift","ios","unit-test"]),
            FakeModel(id: 2, name: "Bob", isActive: false, score: 80.0, tags: ["backend","api"]),
            FakeModel(id: 3, name: "Charlie", isActive: true, score: 70.25, tags: ["design","ux"])
        ]

        // When
        let decodedModels = try sut.decodeJSON(
            pathCreator: { _ in fileURL.path },
            urlBuilder: { URL(fileURLWithPath: $0) }
        )

        // Then
        XCTAssertEqual(
            decodedModels,
            expectedModels,
            "Decoded array does not match expected array of FakeModel objects."
        )
    }

    func testDecodeJSON_differentElements() throws {
        // Given: JSON with 5 elements
        let json = """
        [
            {"id": 10, "name": "Anna", "isActive": false, "score": 88.1, "tags": ["team","leader"]},
            {"id": 11, "name": "Brian", "isActive": true, "score": 92.3, "tags": ["swift","ios"]},
            {"id": 12, "name": "Clara", "isActive": false, "score": 60.0, "tags": ["qa","automation"]},
            {"id": 13, "name": "David", "isActive": true, "score": 78.5, "tags": ["backend"]},
            {"id": 14, "name": "Eve", "isActive": true, "score": 85.0, "tags": ["frontend","ui"]}
        ]
        """

        let fileURL = try writeMockJSON(
            fileName: "five_elements",
            jsonString: json
        )

        let sut = JSONFileParser<[FakeModel]>(
            fileName: "five_elements"
        )

        let expectedModels = [
            FakeModel(id: 10, name: "Anna", isActive: false, score: 88.1, tags: ["team","leader"]),
            FakeModel(id: 11, name: "Brian", isActive: true, score: 92.3, tags: ["swift","ios"]),
            FakeModel(id: 12, name: "Clara", isActive: false, score: 60.0, tags: ["qa","automation"]),
            FakeModel(id: 13, name: "David", isActive: true, score: 78.5, tags: ["backend"]),
            FakeModel(id: 14, name: "Eve", isActive: true, score: 85.0, tags: ["frontend","ui"])
        ]

        // When
        let decodedModels = try sut.decodeJSON(
            pathCreator: { _ in fileURL.path },
            urlBuilder: { URL(fileURLWithPath: $0) }
        )

        // Then
        XCTAssertEqual(
            decodedModels,
            expectedModels,
            "Decoded array does not match expected array of five FakeModel objects."
        )
    }

    func testDecodeJSON_fileNotFoundThrowsError() {
        // Given
        let sut = JSONFileParser<[FakeModel]>(
            fileName: "non_existing_file"
        )

        // When / Then
        XCTAssertThrowsError(
            try sut.decodeJSON(pathCreator: { _ in nil }),
            "Expected decodeJSON to throw JSONParsingError.fileNotFound when the JSON file does not exist."
        ) { error in
            XCTAssertEqual(
                error as? JSONParsingError,
                .fileNotFound,
                "Thrown error was not JSONParsingError.fileNotFound."
            )
        }
    }

    func testDecodeJSON_emptyJSONReturnsEmptyArray() throws {
        // Given: JSON is an empty array
        let json = "[]"

        let fileURL = try writeMockJSON(
            fileName: "empty_array",
            jsonString: json
        )

        let sut = JSONFileParser<[FakeModel]>(
            fileName: "empty_array"
        )

        // When
        let decodedModels = try sut.decodeJSON(
            pathCreator: { _ in fileURL.path },
            urlBuilder: { URL(fileURLWithPath: $0) }
        )

        let expectedModels = [FakeModel]()

        // Then
        XCTAssertEqual(
            decodedModels,
            expectedModels,
            "Decoding an empty JSON array should return an empty array, but it did not."
        )
    }
}

struct FakeModel: Codable, Equatable {
    let id: Int
    let name: String
    let isActive: Bool
    let score: Double
    let tags: [String]
}

