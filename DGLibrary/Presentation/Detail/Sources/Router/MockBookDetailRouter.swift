//
//  MockBookDetailRouter.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//

import Foundation

final class MockBookDetailRouter: BookDetailRouter {
    var didCallPresentPDF: Bool = false
    var capturedPDFURL: URL?
    
    func presentPDF(url: URL) {
        didCallPresentPDF = true
        capturedPDFURL = url
    }
}
