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
    
    private var currentQuery: String = ""
    private var currentPage: Int = 1
    private var allBooks: [BookSearch] = []
    
    init(repository: BookRepository) {
        self.repository = repository
    }
    
    func search(request: BookSearchModel.Fetch.Request) {
        ///상태 초기화
        currentQuery = request.query
        currentPage = 1
        allBooks = []
        
        ///repository에서 검색 요청 후 상태 갱신
        Task {
            do {
                let result = try await repository.fetchBookSearch(
                    query: request.query,
                    page: 1
                )
                self.allBooks = result.books
                
                let response = BookSearchModel.Fetch.Response()
                
                await MainActor.run {
                    presenter?.presentSearchBooks(response: response)
                }
                
            } catch {
                ///검색 실패 시 예외처리
            }
        }
    }

    func next(request: BookSearchModel.Next.Request) {
        let nextPage = currentPage + 1
        
        ///repository에서 검색 요청 후 상태 갱신
        Task {
            do  {
                let result = try await repository.fetchBookSearch(
                    query: currentQuery,
                    page: nextPage
                )
                
                currentPage = nextPage
                self.allBooks.append(contentsOf: result.books)
                
                let response = BookSearchModel.Next.Response()
                
                await MainActor.run {
                    presenter?.presentNextBooks(response: response)
                }
                
            } catch {
                ///로드 실패 시 예외처리
            }
        }
        
    }

    func select(request: BookSearchModel.Select.Request) {
        let response = BookSearchModel.Select.Response()
        presenter?.presentBookDetail(response: response)
    }
}
