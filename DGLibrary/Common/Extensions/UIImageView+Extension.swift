//
//  UIImageView+Extension.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//

import UIKit

extension UIImageView {
    private static var taskKey: UInt8 = 0
    private static var urlKey: UInt8 = 0
    
    private var imageTask: Task<Void, Never>? {
        get { objc_getAssociatedObject(self, &Self.taskKey) as? Task<Void, Never> }
        set { objc_setAssociatedObject(self, &Self.taskKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    
    private var currentImageURL: String? {
        get { objc_getAssociatedObject(self, &Self.urlKey) as? String }
        set { objc_setAssociatedObject(self, &Self.urlKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    
    func setImage(with url: URL?, placeholder: UIImage? = nil) {
        imageTask?.cancel()
        imageTask = nil
        
        guard let url else {
            self.image = placeholder
            return
        }
        
        self.image = placeholder
        
        let urlString = url.absoluteString
        currentImageURL = urlString
        
        let key = urlString
        
        imageTask = Task { [weak self] in
            guard let self = self else { return }
            
            guard !Task.isCancelled else { return }
            
            if let cachedImage = await ImageCache.shared.retrieve(for: key) {
                guard !Task.isCancelled,
                      self.currentImageURL == urlString else {
                    return
                }
                
                await MainActor.run {
                    self.image = cachedImage
                }
                return
            }
            
            do {
                let image = try await ImageDownloader.shared.download(from: url)
                
                guard !Task.isCancelled,
                      self.currentImageURL == urlString else {
                    return
                }
                
                 ImageCache.shared.store(image, for: key)
                
                await MainActor.run {
                    self.image = image
                }
            } catch {
                print("Image download failed: \(error)")
            }
        }
    }
    
    func cancelImageLoad() {
        imageTask?.cancel()
        imageTask = nil
        currentImageURL = nil
    }
}
