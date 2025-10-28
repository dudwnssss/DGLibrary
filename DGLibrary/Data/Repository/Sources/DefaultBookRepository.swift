//
//  DefaultBookRepository.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import Foundation

final class DefaultBookRepository: BookRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchBookSearch(query: String, page: Int) async throws -> BookSearchList {
        let endPoint = BookAPI.search(query: query, page: page)
        let dto: BookSearchListDTO = try await networkService.request(endPoint)
    
        return dto.toDomain()
    }

    func fetchBookDetail(isbn13: String) async throws -> BookDetail {
        let endPoint = BookAPI.detail(isbn13: isbn13)
        let dto: BookDetailDTO = try await networkService.request(endPoint)
        
        return dto.toDomain()
    }
}
