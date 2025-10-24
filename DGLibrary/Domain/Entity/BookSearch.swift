//
//  BookSearch.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import Foundation

struct BookSearchList {
    let total: Int
    let page: Int
    let books: [BookSearch]
}

struct BookSearch {
    let title: String
    let subtitle: String
    let isbn13: String
    let price: Double
    let imageURL: URL?
    let detailURL: URL?
}
