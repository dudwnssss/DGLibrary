//
//  BookSearchInteractor.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import Foundation

protocol BookSearchInteractor {
    func search(request: BookSearchModel.Fetch.Request)
    func next(request: BookSearchModel.Next.Request)
    func select(request: BookSearchModel.Select.Request)
}

final class DefaultBookSearchInteractor: BookSearchInteractor {
    var presenter: BookSearchPresenter?
    private let repository: BookRepository
    
    private var allBooks: [BookSearch] = []
    private var currentQuery: String = ""
    private var currentPage: Int = 1
    private var totalCount: Int = 0
    
    private var hasNextPage: Bool {
        guard !allBooks.isEmpty,
              totalCount > 0 else { return false }
        
        return allBooks.count < totalCount
    }
    private var isLoadingMore: Bool = false
    
    init(repository: BookRepository) {
        self.repository = repository
    }
    
    func search(request: BookSearchModel.Fetch.Request) {
        ///상태 초기화
        allBooks = []
        currentQuery = request.query
        currentPage = 1
        
        ///repository에서 검색 요청 후 상태 갱신
        Task {
            do {
                let result = try await repository.fetchBookSearch(
                    query: request.query,
                    page: 1
                )
                self.allBooks = result.books
                self.currentPage = result.page
                self.totalCount = result.total
                
                let response = BookSearchModel.Fetch.Response(
                    books: result.books,
                    totalCount: result.total,
                    currentPage: result.page
                )
                
                await MainActor.run {
                    presenter?.presentSearchBooks(response: response)
                }
                
            } catch {
                ///검색 실패 시 예외처리
                presenter?.presentError(error: error)
            }
        }
    }

    func next(request: BookSearchModel.Next.Request) {
        guard hasNextPage,
              !isLoadingMore else { return }
        
        isLoadingMore = true
        let nextPage = currentPage + 1
        
        ///repository에서 검색 요청 후 상태 갱신
        Task {
            do  {
                let result = try await repository.fetchBookSearch(
                    query: currentQuery,
                    page: nextPage
                )
                
                self.allBooks.append(contentsOf: result.books)
                self.currentPage = nextPage

                let response = BookSearchModel.Next.Response(books: result.books)
                
                await MainActor.run {
                    presenter?.presentNextBooks(response: response)
                }
                
            } catch {
                ///로드 실패 시 예외처리
            }
            isLoadingMore = false
        }
        
    }

    func select(request: BookSearchModel.Select.Request) {
        guard request.index >= 0,
              request.index < allBooks.count else {
            return
        }
        
        let book = allBooks[request.index]
        let response = BookSearchModel.Select.Response(isbn13: book.isbn13)
        
        presenter?.presentBookDetail(response: response)
    }
}
