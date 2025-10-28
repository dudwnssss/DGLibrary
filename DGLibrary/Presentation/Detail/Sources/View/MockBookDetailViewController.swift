//
//  MockBookDetailViewController.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//

import Foundation

final class MockBookDetailViewController: BookDetailDisplay {
    var didCallDisplayDetailResult: Bool = false
    var capturedViewModel: BookDetailModel.Fetch.ViewModel?
    var didCallDisplayError = false
    var capturedMessage: String?
    
    func displayDetailResult(viewModel: BookDetailModel.Fetch.ViewModel) {
        didCallDisplayDetailResult = true
        capturedViewModel = viewModel
    }

    func displayError(message: String) {
        didCallDisplayError = true
        capturedMessage = message
    }
}
