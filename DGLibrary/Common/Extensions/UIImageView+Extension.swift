//
//  UIImageView+Extension.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//

import UIKit

extension UIImageView {
    func setImage(with url: URL?, placeholder: UIImage? = nil) {
        guard let url else { return }
        self.image = placeholder
        let key = url.absoluteString
        
        Task {
            if let cachedImage = await ImageCache.shared.retrieve(for: key) {
                await MainActor.run {
                    self.image = cachedImage
                }
                return
            }
            
            do {
                let image = try await ImageDownloader.shared.download(from: url)
                ImageCache.shared.store(image, for: key)
                await MainActor.run {
                    self.image = image
                }
            } catch {
                
            }
        }
    }
}
