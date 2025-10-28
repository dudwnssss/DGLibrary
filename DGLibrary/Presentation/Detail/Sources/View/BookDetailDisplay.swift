//
//  BookDetailDisplay.swift
//  DGLibrary
//
//  Created by 임영준 on 10/26/25.
//

import Foundation

protocol BookDetailDisplay: AnyObject {
    func displayDetailResult(viewModel: BookDetailModel.Fetch.ViewModel)
    func displayError(message: String)
    func displayLoading(viewModel: BookDetailModel.Loading.ViewModel)
}
