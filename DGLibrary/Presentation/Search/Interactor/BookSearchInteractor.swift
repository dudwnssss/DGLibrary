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
    
    private var currentQuery: String = ""
    private var currentPage: Int = 1
    private var allBooks: [BookSearch] = []
    
    
    func search(request: BookSearchModel.Fetch.Request) {
        ///상태 초기화
        currentQuery = request.query
        currentPage = 1
        allBooks = []
        
        ///repository에서 검색 요청 후 상태 갱신
    }

    func next(request: BookSearchModel.Next.Request) {
        
        ///repository에서 검색 요청 후 상태 갱신
    }

    func select(request: BookSearchModel.Select.Request) {
        let mockResponse = BookSearchModel.Select.Response()
        presenter?.presentBookDetail(request: mockResponse)
    }
}
