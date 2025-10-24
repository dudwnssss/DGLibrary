//
//  BookDetail.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import Foundation

struct BookDetail {
    let error: Int
    let title: String
    let subtitle: String
    let authors: [String]
    let publisher: String
    let isbn10: String
    let isbn13: String
    let pages: Int
    let year: Int
    let rating: Double
    let desc: String
    let price: Double
    let imageURL: URL?
    let detailURL: URL?
    let pdf: [PDFChapter]
}

struct PDFChapter {
    let title: String
    let url: URL?
}
