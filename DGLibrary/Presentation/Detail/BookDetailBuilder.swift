//
//  BookDetailBuilder.swift
//  DGLibrary
//
//  Created by 임영준 on 10/26/25.
//

import UIKit

enum BookDetailBuilder {
    static func build(isbn13: String) -> UIViewController {
        let viewController = BookDetailViewController()
        
        return viewController
    }
}
