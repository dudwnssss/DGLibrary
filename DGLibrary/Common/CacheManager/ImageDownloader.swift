//
//  ImageDownloader.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import UIKit

final class ImageDownloader {
    static let shared = ImageDownloader()
    
    private init() {}
    
    func downloadImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw ImageDownloadError.invalidData
        }
        
        return image
    }
}

enum ImageDownloadError: Error {
    case invalidData
}

extension UIImageView {
    func setImage(with url: URL?, placeholder: UIImage? = nil) {
        guard let url else { return }
        self.image = placeholder
        
        Task {
            do {
                let image = try await ImageDownloader.shared.downloadImage(from: url)
                self.image = image
            } catch {
                
            }
        }
    }
}
