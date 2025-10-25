//
//  MockBookRepository.swift
//  DGLibrary
//
//  Created by 임영준 on 10/25/25.
//

import Foundation

final class MockBookRepository: BookRepository {
    func fetchBookSearch(query: String, page: Int) async throws -> BookSearchList {
        return .init(
            total: 100,
            page: page,
            books: [
                .init(
                    title: "iOS Programming: The Big Nerd Ranch Guide",
                    subtitle: "8th Edition",
                    isbn13: "9780135264027",
                    price: 49.99,
                    imageURL: URL(string: "https://example.com/images/book1.jpg"),
                    detailURL: URL(string: "https://example.com/books/9780135264027")
                ),
                .init(
                    title: "Swift Programming",
                    subtitle: "The Big Nerd Ranch Guide",
                    isbn13: "9780135264386",
                    price: 44.99,
                    imageURL: URL(string: "https://example.com/images/book2.jpg"),
                    detailURL: URL(string: "https://example.com/books/9780135264386")
                )
            ]
        )
    }

    func fetchBookDetail(isbn13: String) async throws -> BookDetail {
        return .init(
            error: 0,
            title: "iOS Programming: The Big Nerd Ranch Guide",
            subtitle: "8th Edition",
            authors: ["Christian Keur", "Aaron Hillegass"],
            publisher: "Big Nerd Ranch Guides",
            isbn10: "0135264022",
            isbn13: "9780135264027",
            pages: 600,
            year: 2021,
            rating: 4.5,
            desc: "Updated for Xcode 12, iOS 14, and Swift 5.3, this guide covers the essential topics needed to start building iOS applications.",
            price: 49.99,
            imageURL: URL(string: "https://example.com/images/book1.jpg"),
            detailURL: URL(string: "https://example.com/books/9780135264027"),
            pdf: [
                .init(title: "Chapter 1", url: URL(string: "https://example.com/pdf/chapter1.pdf")!),
                .init(title: "Chapter 2", url: URL(string: "https://example.com/pdf/chapter2.pdf")!)
            ]
        )
    }
}
