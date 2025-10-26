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
    func presentError(error: Error)
}

final class DefaultBookSearchPresenter: BookSearchPresenter {
    weak var viewController: BookSearchDisplay?
    var router: BookSearchRouter?
    
    func presentSearchBooks(response: BookSearchModel.Fetch.Response) {
        let displayedBooks = response.books.map { book in
            BookSearchModel.Fetch.ViewModel
                .DisplayedBook(
                    title: book.title,
                    subTitle: book.subtitle,
                    isbn13: book.isbn13,
                    price: "\(book.price)",
                    imageURL: "\(book.imageURL)",
                    detailURL: "\(book.detailURL)"
                )
        }
        let viewModel = BookSearchModel.Fetch.ViewModel(books: displayedBooks)

        viewController?.displaySearchResults(viewModel: viewModel)
    }

    func presentNextBooks(response: BookSearchModel.Next.Response) {
        
    }

    func presentBookDetail(response: BookSearchModel.Select.Response) {
        router?.navigateToBookDetail(isbn13: response.isbn13)
    }
    
    func presentError(error: any Error) {
        
    }
}
