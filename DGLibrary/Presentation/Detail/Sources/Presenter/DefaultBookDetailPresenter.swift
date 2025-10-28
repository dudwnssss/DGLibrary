//
//  BookDetailPresenter.swift
//  DGLibrary
//
//  Created by 임영준 on 10/26/25.
//

import Foundation

final class DefaultBookDetailPresenter: BookDetailPresenter {
    weak var viewController: BookDetailDisplay?
    var router: BookDetailRouter?
    
    func presentDetailBook(response: BookDetailModel.Fetch.Response) {
        let displayedBook = convertToDisplayedBook(response.book)
        let viewModel = BookDetailModel.Fetch.ViewModel(book: displayedBook)
        
        viewController?.displayDetailResult(viewModel: viewModel)
    }
    
    func presentPDF(response: BookDetailModel.PDF.Resopnse) {
        let url = response.pdfURL
        router?.presentPDF(url: url)
    }
    
    func presentError(error: any Error) {
        viewController?.displayError()
    }
    
    private func convertToDisplayedBook(_ book: BookDetail) -> BookDetailModel.DisplayedBook {
        let authors = book.authors.joined(separator: ", ")
        let rating = "★ \(book.rating)"
        let pages = "\(book.pages)page"
        let year = "\(book.year)"
        let price = formatPrice(book.price)
        
        return BookDetailModel
            .DisplayedBook(
                title: book.title,
                subtitle: book.subtitle,
                authors: authors,
                publisher: book.publisher,
                isbn10: book.isbn10,
                isbn13: book.isbn13,
                pages: pages,
                year: year,
                rating: rating,
                desc: book.desc,
                price: price,
                imageURL: book.imageURL,
                detailUrl: book.detailURL,
                pdfs: book.pdf
            )
    }
    
    private func formatPrice(_ price: Double) -> String {
        return String(format: "$%.2f", price)
    }
}
