//
//  MemoryCache.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import UIKit

final class MemoryCache: Cache {
    private let cache = NSCache<NSString, UIImage>()
    
    init() {
        configureCache()
        observeMemoryWarnings()
    }
        
    private func configureCache() {
        cache.totalCostLimit = CacheConfiguration.memoryCacheLimit
        
        #if DEBUG
        let limitMB = cache.totalCostLimit / 1024 / 1024
        print("🔧 Memory Cache Configured: \(limitMB)MB limit, \(cache.countLimit) items max")
        #endif
    }
        
    func store(_ image: UIImage, for key: String) {
        let cost = calculateBitmapSize(image)
        cache.setObject(image, forKey: key as NSString, cost: cost)
        
        #if DEBUG
        print("📦 Memory cached: \(key.suffix(20)), \(cost / 1024)KB")
        #endif
    }
    
    func retrieve(for key: String) async -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func remove(for key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func clearAll() {
        cache.removeAllObjects()
        #if DEBUG
        print("🗑️ Memory cache cleared")
        #endif
    }
        
    private func calculateBitmapSize(_ image: UIImage) -> Int {
        guard let cgImage = image.cgImage else { return 0 }
        // RGBA = 4 bytes per pixel
        return cgImage.bytesPerRow * cgImage.height
    }
        
    private func observeMemoryWarnings() {
        NotificationCenter.default.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.handleMemoryWarning()
        }
    }
    
    private func handleMemoryWarning() {
        clearAll()
        print("🚨 Memory warning received: Cache cleared")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
