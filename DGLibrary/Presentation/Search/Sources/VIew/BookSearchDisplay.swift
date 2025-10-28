//
//  BookSearchDisplay.swift
//  DGLibrary
//
//  Created by 임영준 on 10/25/25.
//

import Foundation

protocol BookSearchDisplay: AnyObject {
    func displaySearchResults(viewModel: BookSearchModel.Fetch.ViewModel)
    func displayMoreBooks(viewModel: BookSearchModel.Next.ViewModel)
    func displayEmptyAlert(viewModel: BookSearchModel.Empty.ViewModel)
    func displayError(message: String)
    func displayLoading(viewModel: BookSearchModel.Loading.ViewModel)
}
