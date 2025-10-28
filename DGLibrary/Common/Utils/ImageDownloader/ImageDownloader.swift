//
//  ImageDownloader.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//

import UIKit

final class ImageDownloader {
    static let shared = ImageDownloader()
    
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = CacheConfiguration.downloadTimeout
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: config)
    }
    
    func download(from url: URL) async throws -> UIImage {
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ImageDownloadError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ImageDownloadError.serverError(statusCode: httpResponse.statusCode)
        }

        
        guard let image = UIImage(data: data) else {
            throw ImageDownloadError.invalidData
        }
        
        return image
    }
}
