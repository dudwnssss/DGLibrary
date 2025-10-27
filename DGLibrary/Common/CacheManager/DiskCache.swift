//
//  DiskCache.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import UIKit

final class DiskCache: Cache {
    private let cacheURL: URL
    private let queue = DispatchQueue(label: "com.dglibrary.diskCache", qos: .utility)

    init() {
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        
        cacheURL = directory.appendingPathComponent("ImageCache")
        try? FileManager.default.createDirectory(at: cacheURL, withIntermediateDirectories: true)
    }
    
    private func fileURL(for key: String) -> URL {
        return cacheURL.appendingPathComponent(key)
    }

    func store(_ image: UIImage, for key: String) {
        queue.async { [weak self] in
            guard let data = image.jpegData(compressionQuality: 0.8),
                  let self else { return }
            try? data.write(to: self.fileURL(for: key))
        }
    }

    func retrieve(for key: String) async -> UIImage? {
        return await withCheckedContinuation { continuation in
            queue.async { [weak self] in
                guard let self,
                      let data = try? Data(contentsOf: self.fileURL(for: key)),
                      let image = UIImage(data: data) else {
                    continuation.resume(returning: nil)
                    return
                }
                continuation.resume(returning: image)
            }
        }
    }
    
    func remove(for key: String) {
        queue.async { [weak self] in
            guard let self else { return }
            try? FileManager.default.removeItem(at: self.fileURL(for: key))
        }
    }
    
    func clearAll() {
        queue.async { [weak self] in
            guard let self else { return }
            try? FileManager.default.removeItem(at: self.cacheURL)
            try? FileManager.default.createDirectory(at: self.cacheURL, withIntermediateDirectories: true)
        }
    }
}
