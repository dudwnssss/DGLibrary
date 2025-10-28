//
//  DefaultBookSearchRouter.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//


import UIKit

final class DefaultBookSearchRouter: BookSearchRouter {
    weak var viewController: UIViewController?
    
    func navigateToBookDetail(isbn13: String) {
        let vc = BookDetailBuilder.build(isbn13: isbn13)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
