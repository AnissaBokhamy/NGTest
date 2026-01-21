//
//  DataDownloader.swift
//  NGTest
//
//  Created by Anissa Bokhamy on 2026-01-20.
//  Copyright © 2026 Nuglif. All rights reserved.
//

import Foundation

enum DataDownloaderError: Error {
    case invalidURL
    case downloadError
    case conversionError
}

struct DataDownloader<T> {

    let urlBuilder: (String) -> URL?
    let downloader: (URL) async throws -> Data
    let dataConverter: (Data) -> T?

    init(
        urlBuilder: @escaping (String) -> URL? = { urlString in URL(string: urlString) },
        downloader: @escaping (URL) async throws -> Data = { url in try await URLSession.shared.data(from: url).0 },
        dataConverter: @escaping (Data) -> T?
    ) {
        self.urlBuilder = urlBuilder
        self.downloader = downloader
        self.dataConverter = dataConverter
    }

    func downloadData(from urlString: String) async throws -> T {
        guard let url = urlBuilder(urlString) else {
            throw DataDownloaderError.invalidURL
        }
        do {
            let downloadedData = try await downloader(url)
            guard let convertedData = dataConverter(downloadedData) else {
                throw DataDownloaderError.conversionError
            }
            return convertedData
        } catch {
            throw DataDownloaderError.downloadError
        }
    }
}
