//
//  MockBookSearchViewController.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//

import Foundation

final class MockBookSearchViewController: BookSearchDisplay {
    var didCallDisplaySearchResults = false
    var capturedViewModel: BookSearchModel.Fetch.ViewModel?
    var didCallDisplayError = false
    var capturedMessage: String?
    
    func displaySearchResults(viewModel: BookSearchModel.Fetch.ViewModel) {
        didCallDisplaySearchResults = true
        capturedViewModel = viewModel
    }

    func displayMoreBooks(viewModel: BookSearchModel.Next.ViewModel) {
        
    }

    func displayError(message: String) {
        didCallDisplayError = true
        capturedMessage = message
    }
}
