//
//  MockBookSearchRouter.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//

import Foundation

final class MockBookSearchRouter: BookSearchRouter {
    var didCallNavigateToDetail = false
    var capturedISBN: String?
    
    func navigateToBookDetail(isbn13: String) {
        didCallNavigateToDetail = true
        capturedISBN = isbn13
    }
}
