//
//  DiskCache.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import UIKit

final class DiskCache: Cache {
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    private let queue = DispatchQueue(label: "com.dglibrary.diskCache", qos: .utility)

    init() {
        let cachesDirectory = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )[0]
        
        self.cacheDirectory = cachesDirectory
            .appendingPathExtension(CacheConfiguration.cacheFolderName)
        createCacheDirectoryIfNeeded()
    }

    func store(_ image: UIImage, for key: String) {
        queue.async { [weak self] in
            guard let self,
                  let data = image.jpegData(compressionQuality: 0.8) else { return }
            
            let fileURL = fileURL(for: key)
            
            do {
                try data.write(to: fileURL)
                Task {
                    await self.cleanupIfNeeded()
                }
            } catch {
                //log Failed to save to disk
            }
        }
    }

    func retrieve(for key: String) async -> UIImage? {
        return await withCheckedContinuation { continuation in
            queue.async { [weak self] in
                guard let self else {
                    continuation.resume(returning: nil)
                    return
                }
                let fileURL = fileURL(for: key)
                
                guard fileManager.fileExists(atPath: fileURL.path) else {
                    continuation.resume(returning: nil)
                    return
                }
                
                guard !isExpired(fileURL: fileURL) else {
                    try? self.fileManager.removeItem(at: fileURL)
                    continuation.resume(returning: nil)
                    return
                }
                
                guard let data = try? Data(contentsOf: fileURL),
                      let image = UIImage(data: data) else {
                    continuation.resume(returning: nil)
                    return
                }
                
                updateAccessDate(fileURL: fileURL)
                continuation.resume(returning: image)
            }
        }
    }
    
    func remove(for key: String) {
        queue.async { [weak self] in
            guard let self else { return }
            let url = fileURL(for: key)
            try? fileManager.removeItem(at: url)
        }
    }
    
    func clearAll() {
        queue.async { [weak self] in
            guard let self else { return }
            try? fileManager.removeItem(at: self.cacheDirectory)
            createCacheDirectoryIfNeeded()
        }
    }
    
    private func createCacheDirectoryIfNeeded() {
        guard !fileManager.fileExists(atPath: cacheDirectory.path) else { return }
        
        do {
            try fileManager.createDirectory(
                at: cacheDirectory,
                withIntermediateDirectories: true
            )
        } catch {
            
        }
    }
    
    private func cleanupIfNeeded() async {
        let currentSize = await calculateDirectorySize()
        
        guard currentSize > CacheConfiguration.diskCacheLimit else { return }
        
        await removeOldestFiles(targetSize: CacheConfiguration.diskCacheTargetSize)
    }
    
    private func calculateDirectorySize() async -> Int {
        guard let enumerator = fileManager.enumerator(
            at: cacheDirectory,
            includingPropertiesForKeys: [.fileSizeKey]
        ) else { return 0 }
        
        var totalSize = 0
        
        for case let fileURL as URL in enumerator {
            if let size = try? fileURL.resourceValues(forKeys: [.fileSizeKey]).fileSize {
                totalSize += size
            }
        }
        
        return totalSize
    }
    
    private func removeOldestFiles(targetSize: Int) async {
        guard let files = try? fileManager.contentsOfDirectory(
              at: cacheDirectory,
              includingPropertiesForKeys: [.contentAccessDateKey, .fileSizeKey]
          ) else { return }
        
        let sortedFiles = files.sorted { file1, file2 in
            let date1 = try? file1.resourceValues(forKeys: [.contentAccessDateKey]).contentAccessDate
            let date2 = try? file2.resourceValues(forKeys: [.contentAccessDateKey]).contentAccessDate
            return (date1 ?? .distantPast) < (date2 ?? .distantPast)
        }
        
        var currentSize = await calculateDirectorySize()
        
        for file in sortedFiles {
            guard currentSize > targetSize else { return }
            
            if let size = try? file.resourceValues(forKeys: [.fileSizeKey]).fileSize {
                try? fileManager.removeItem(at: file)
                currentSize -= size
            }
        }
    }
    
    private func fileURL(for key: String) -> URL {
        let fileName = key.md5() + ".cache"
        return cacheDirectory.appendingPathComponent(fileName)
    }
    
    private func isExpired(fileURL: URL) -> Bool {
        guard let attributes = try? fileManager.attributesOfItem(atPath: fileURL.path()),
              let modificationDate = attributes[.modificationDate] as? Date else {
            return true
        }
        
        let expirationDate = modificationDate.addingTimeInterval(CacheConfiguration.cacheExpiration)
        return Date() > expirationDate
    }
    
    private func updateAccessDate(fileURL: URL) {
        let now = Date()
        try? fileManager.setAttributes(
            [.modificationDate: now],
            ofItemAtPath: fileURL.path()
        )
    }
}
