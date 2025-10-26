//
//  BookSearchRouter.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import UIKit

protocol BookSearchRouter {
    func navigateToBookDetail(isbn13: String)
}

final class DefaultBookSearchRouter: BookSearchRouter {
    weak var viewController: UIViewController?
    
    func navigateToBookDetail(isbn13: String) {
        ///1. builder에서 detailVC생성
        ///2. navigation
    }
}
