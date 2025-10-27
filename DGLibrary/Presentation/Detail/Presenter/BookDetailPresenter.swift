//
//  BookDetailPresenter.swift
//  DGLibrary
//
//  Created by 임영준 on 10/26/25.
//

import Foundation

protocol BookDetailPresenter {
    func presentDetailBook(response: BookDetailModel.Fetch.Response)
    func presentError(error: Error)
}

final class DefaultBookDetailPresenter: BookDetailPresenter {
    weak var viewController: BookDetailDisplay?
    
    func presentDetailBook(response: BookDetailModel.Fetch.Response) {
        let displayedBook = convertToDisplayedBook(response.book)
        let viewModel = BookDetailModel.Fetch.ViewModel(book: displayedBook)
        
        viewController?.displayDetailResult(viewModel: viewModel)
    }
    
    func presentError(error: any Error) {
        viewController?.displayError()
    }
    
    private func convertToDisplayedBook(_ book: BookDetail) -> BookDetailModel.DisplayedBook {
        return BookDetailModel
            .DisplayedBook(
                title: book.title,
                subtitle: book.subtitle,
                authors: "",
                publisher: book.publisher,
                isbn10: book.isbn10,
                isbn13: book.isbn13,
                pages: "",
                year: "",
                rating: "",
                desc: book.desc,
                price: "",
                imageURL: book.imageURL,
                detailUrl: book.detailURL
            )
    }
}
