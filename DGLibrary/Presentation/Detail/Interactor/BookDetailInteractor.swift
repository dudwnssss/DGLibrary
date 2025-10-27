//
//  BookDetailInteractor.swift
//  DGLibrary
//
//  Created by 임영준 on 10/26/25.
//

import Foundation

protocol BookDetailInteractor {
    func fetch(request: BookDetailModel.Fetch.Request)
}

final class DefaultBookDetailInteractor: BookDetailInteractor {
    var presenter: BookDetailPresenter?
    private let repository: BookRepository
    
    init(repository: BookRepository) {
        self.repository = repository
    }
    
    func fetch(request: BookDetailModel.Fetch.Request) {
        Task {
            do {
                let result = try await repository.fetchBookDetail(isbn13: request.isbn13)
                let response = BookDetailModel.Fetch.Response(book: result)
                
                await MainActor.run {
                    presenter?.presentDetailBook(response: response)
                }
            } catch {
                presenter?.presentError(error: error)
            }
        }
    }
}
