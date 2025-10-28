//
//  ImageCache.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private let memoryCache: Cache
    private let diskCache: Cache
    
    private init(
        memoryCache: Cache = MemoryCache(),
        diskCache: Cache = DiskCache()
    ) {
        self.memoryCache = memoryCache
        self.diskCache = diskCache
    }
    
    func store(_ image: UIImage, for key: String) {
        memoryCache.store(image, for: key)
        diskCache.store(image, for: key)
    }
    
    func retrieve(for key: String) async -> UIImage? {
        if let image = await memoryCache.retrieve(for: key) {
            return image
        }
        if let image = await diskCache.retrieve(for: key) {
            memoryCache.store(image, for: key)
            return image
        }
        return nil
    }
    
    func remove(for key: String) {
        memoryCache.remove(for: key)
        diskCache.remove(for: key)
    }
    
    func clearAll() {
        memoryCache.clearAll()
        diskCache.clearAll()
    }
}
