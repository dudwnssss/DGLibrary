//
//  Cache.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import UIKit

protocol Cache {
    func store(_ image: UIImage, for key: String)
    func retrieve(for key: String) async -> UIImage?
    func remove(for key: String)
    func clearAll()
}
