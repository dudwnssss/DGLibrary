//
//  BookSearchPresenter.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import Foundation

protocol BookSearchPresenter {
    func presentSearchBooks(response: BookSearchModel.Fetch.Response)
    func presentNextBooks(response: BookSearchModel.Next.Response)
    func presentBookDetail(response: BookSearchModel.Select.Response)
    func presentEmptyResult(response: BookSearchModel.Empty.Response)
    func presentError(error: Error)
    func presentLoading(response: BookSearchModel.Loading.Response)
    func presentHideLoading(response: BookSearchModel.Loading.Response)
}

final class DefaultBookSearchPresenter: BookSearchPresenter {
    weak var viewController: BookSearchDisplay?
    var router: BookSearchRouter?
    
    func presentSearchBooks(response: BookSearchModel.Fetch.Response) {
        let displayedBooks = response.books.map { convertToDisplayedBook($0) }
        let viewModel = BookSearchModel.Fetch.ViewModel(books: displayedBooks)

        viewController?.displaySearchResults(viewModel: viewModel)
    }

    func presentNextBooks(response: BookSearchModel.Next.Response) {
        let displayedBooks = response.books.map { convertToDisplayedBook($0) }
        let viewModel = BookSearchModel.Next.ViewModel(books: displayedBooks)
        
        viewController?.displayMoreBooks(viewModel: viewModel)
    }

    func presentBookDetail(response: BookSearchModel.Select.Response) {
        router?.navigateToBookDetail(isbn13: response.isbn13)
    }
    
    func presentEmptyResult(response: BookSearchModel.Empty.Response) {
        let viewModel = BookSearchModel.Empty.ViewModel(query: response.query)
        viewController?.displayEmptyAlert(viewModel: viewModel)
    }
    
    func presentError(error: any Error) {
        viewController?.displayError(message: error.localizedDescription)
    }
    
    func presentLoading(response: BookSearchModel.Loading.Response) {
        let viewModel = BookSearchModel.Loading.ViewModel(isLoading: true, type: response.type)
        viewController?.displayLoading(viewModel: viewModel)
    }

    func presentHideLoading(response: BookSearchModel.Loading.Response) {
        let viewModel = BookSearchModel.Loading.ViewModel(isLoading: false, type: response.type)
        viewController?.displayLoading(viewModel: viewModel)
    }
    
    private func convertToDisplayedBook(_ book: BookSearch) -> BookSearchModel.DisplayedBook {
        return BookSearchModel.DisplayedBook(
            title: book.title,
            subtitle: book.subtitle,
            isbn13: book.isbn13,
            price: formatPrice(book.price),
            imageURL: book.imageURL,
            detailURL: book.detailURL
        )
    }
    
    private func formatPrice(_ price: Double) -> String {
        return String(format: "$%.2f", price)
    }
}
