//
//  DefaultBookSearchInteractor.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//


import Foundation

final class DefaultBookSearchInteractor: BookSearchInteractor {
    var presenter: BookSearchPresenter?
    private let repository: BookRepository
    private let validator: QueryValidator
    
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
    
    init(repository: BookRepository,
         validator: QueryValidator = QueryValidator()) {
        self.repository = repository
        self.validator = validator
    }
    
    func search(request: BookSearchModel.Fetch.Request) {
        do {
            try validator.validate(request.query)
        }  catch {
            presenter?.presentError(error: error)
            return
        }
        
        allBooks = []
        currentQuery = request.query
        currentPage = 1
        
        let loadingResponse = BookSearchModel.Loading.Response(type: .fullscreen)
        presenter?.presentLoading(response: loadingResponse)
        
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
                
                let fetchResponse = BookSearchModel.Fetch.Response(
                    books: result.books,
                    totalCount: result.total,
                    currentPage: result.page
                )
                
                await MainActor.run {
                    if result.books.isEmpty {
                        let response = BookSearchModel.Empty.Response(query: request.query)
                        presenter?.presentEmptyResult(response: response)
                    } else {
                        presenter?.presentSearchBooks(response: fetchResponse)
                    }
                    
                    let loadingResponse = BookSearchModel.Loading.Response(type: .fullscreen)
                    presenter?.presentHideLoading(response: loadingResponse)
                }
                
            } catch {
                ///검색 실패 시 예외처리
                await MainActor.run {
                    let loadingResponse = BookSearchModel.Loading.Response(type: .fullscreen)
                    presenter?.presentHideLoading(response: loadingResponse)
                    presenter?.presentError(error: error)
                }
            }
        }
    }

    func next(request: BookSearchModel.Next.Request) {
        guard hasNextPage,
              !isLoadingMore else { return }
        
        isLoadingMore = true
        let nextPage = currentPage + 1
        
        let loadingResponse = BookSearchModel.Loading.Response(type: .paging)
        presenter?.presentLoading(response: loadingResponse)
        ///repository에서 검색 요청 후 상태 갱신
        Task {
            do  {
                let result = try await repository.fetchBookSearch(
                    query: currentQuery,
                    page: nextPage
                )
                
                self.allBooks.append(contentsOf: result.books)
                self.currentPage = nextPage
                
                let nextResponse = BookSearchModel.Next.Response(books: result.books)
                
                await MainActor.run {
                    let loadingResponse = BookSearchModel.Loading.Response(type: .paging)
                    presenter?.presentHideLoading(response: loadingResponse)
                    presenter?.presentNextBooks(response: nextResponse)
                }
                
            } catch {
                ///로드 실패 시 예외처리
                await MainActor.run {
                    let loadingResponse = BookSearchModel.Loading.Response(type: .paging)
                    presenter?.presentHideLoading(response: loadingResponse)
                    presenter?.presentError(error: error)
                }
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
