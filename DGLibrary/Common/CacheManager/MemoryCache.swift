//
//  MemoryCache.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import UIKit

final class MemoryCache: Cache {
    private let cache = NSCache<NSString, UIImage>()
    
    func store(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func retrieve(for key: String) async -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func remove(for key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func clearAll() {
        cache.removeAllObjects()
    }
}
