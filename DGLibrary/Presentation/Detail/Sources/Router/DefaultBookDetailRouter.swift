//
//  DefaultBookDetailRouter.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//


import UIKit

final class DefaultBookDetailRouter: BookDetailRouter {
    weak var viewController: UIViewController?
    
    func presentPDF(url: URL) {
        let vc = PDFViewController(pdfURL: url)
        viewController?.present(vc, animated: true)
    }
}