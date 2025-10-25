//
//  BookRepository.swift
//  DGLibrary
//
//  Created by 임영준 on 10/25/25.
//

import Foundation

protocol BookRepository {
    func fetchBookSearch(qeury: String, page: Int) async throws -> BookSearchList
    func fetchBookDetail(isbn13: String) async throws -> BookDetail
}
