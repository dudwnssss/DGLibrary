//
//  MockBookRepository.swift
//  DGLibrary
//
//  Created by 임영준 on 10/25/25.
//

import Foundation

final class MockBookRepository: BookRepository {
    private let allMockBooks: [BookSearch] = [
        // iOS & Swift
        .init(
            title: "iOS Programming: The Big Nerd Ranch Guide",
            subtitle: "8th Edition",
            isbn13: "9780135264027",
            price: 49.99,
            imageURL: URL(string: "https://itbook.store/img/books/9780135264027.png"),
            detailURL: URL(string: "https://itbook.store/books/9780135264027")
        ),
        .init(
            title: "Swift Programming",
            subtitle: "The Big Nerd Ranch Guide",
            isbn13: "9780135264386",
            price: 44.99,
            imageURL: URL(string: "https://itbook.store/img/books/9780135264386.png"),
            detailURL: URL(string: "https://itbook.store/books/9780135264386")
        ),
        .init(
            title: "SwiftUI for Masterminds",
            subtitle: "How to take advantage of SwiftUI to create insanely great apps",
            isbn13: "9780990879572",
            price: 54.99,
            imageURL: URL(string: "https://itbook.store/img/books/9780990879572.png"),
            detailURL: URL(string: "https://itbook.store/books/9780990879572")
        ),
        .init(
            title: "Combine: Asynchronous Programming with Swift",
            subtitle: "Writing Elegant Reactive Code",
            isbn13: "9781950325238",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781950325238.png"),
            detailURL: URL(string: "https://itbook.store/books/9781950325238")
        ),
        .init(
            title: "Advanced Swift",
            subtitle: "Updated for Swift 5.5",
            isbn13: "9783958438507",
            price: 47.00,
            imageURL: URL(string: "https://itbook.store/img/books/9783958438507.png"),
            detailURL: URL(string: "https://itbook.store/books/9783958438507")
        ),
        
        // Architecture & Design Patterns
        .init(
            title: "Design Patterns by Tutorials",
            subtitle: "Learning design patterns in Swift",
            isbn13: "9781950325252",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781950325252.png"),
            detailURL: URL(string: "https://itbook.store/books/9781950325252")
        ),
        .init(
            title: "Clean Code",
            subtitle: "A Handbook of Agile Software Craftsmanship",
            isbn13: "9780132350884",
            price: 42.79,
            imageURL: URL(string: "https://itbook.store/img/books/9780132350884.png"),
            detailURL: URL(string: "https://itbook.store/books/9780132350884")
        ),
        .init(
            title: "Refactoring",
            subtitle: "Improving the Design of Existing Code, 2nd Edition",
            isbn13: "9780134757599",
            price: 54.99,
            imageURL: URL(string: "https://itbook.store/img/books/9780134757599.png"),
            detailURL: URL(string: "https://itbook.store/books/9780134757599")
        ),
        .init(
            title: "The Pragmatic Programmer",
            subtitle: "Your Journey To Mastery, 20th Anniversary Edition",
            isbn13: "9780135957059",
            price: 43.99,
            imageURL: URL(string: "https://itbook.store/img/books/9780135957059.png"),
            detailURL: URL(string: "https://itbook.store/books/9780135957059")
        ),
        .init(
            title: "Head First Design Patterns",
            subtitle: "Building Extensible and Maintainable Object-Oriented Software",
            isbn13: "9781492078005",
            price: 64.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781492078005.png"),
            detailURL: URL(string: "https://itbook.store/books/9781492078005")
        ),
        
        // Testing
        .init(
            title: "iOS Test-Driven Development by Tutorials",
            subtitle: "Learn real-world test-driven development",
            isbn13: "9781950325443",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781950325443.png"),
            detailURL: URL(string: "https://itbook.store/books/9781950325443")
        ),
        .init(
            title: "Unit Testing Principles, Practices, and Patterns",
            subtitle: "Effective testing styles, patterns, and reliable automation",
            isbn13: "9781617296277",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781617296277.png"),
            detailURL: URL(string: "https://itbook.store/books/9781617296277")
        ),
        
        // Algorithms & Data Structures
        .init(
            title: "Data Structures & Algorithms in Swift",
            subtitle: "Implement Stacks, Queues, Dictionaries, and Graphs",
            isbn13: "9781950325405",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781950325405.png"),
            detailURL: URL(string: "https://itbook.store/books/9781950325405")
        ),
        .init(
            title: "Grokking Algorithms",
            subtitle: "An Illustrated Guide for Programmers",
            isbn13: "9781617292231",
            price: 44.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781617292231.png"),
            detailURL: URL(string: "https://itbook.store/books/9781617292231")
        ),
        .init(
            title: "Introduction to Algorithms",
            subtitle: "Fourth Edition",
            isbn13: "9780262046305",
            price: 110.00,
            imageURL: URL(string: "https://itbook.store/img/books/9780262046305.png"),
            detailURL: URL(string: "https://itbook.store/books/9780262046305")
        ),
        
        // Concurrency & Async
        .init(
            title: "Modern Concurrency in Swift",
            subtitle: "Asynchronous and Parallel Code",
            isbn13: "9781950325993",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781950325993.png"),
            detailURL: URL(string: "https://itbook.store/books/9781950325993")
        ),
        .init(
            title: "Concurrency by Tutorials",
            subtitle: "Multithreading in Swift with GCD and Operations",
            isbn13: "9781950325207",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781950325207.png"),
            detailURL: URL(string: "https://itbook.store/books/9781950325207")
        ),
        
        // Networking
        .init(
            title: "iOS Networking with Swift",
            subtitle: "Consume and create web services with Swift and iOS",
            isbn13: "9781484265536",
            price: 49.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781484265536.png"),
            detailURL: URL(string: "https://itbook.store/books/9781484265536")
        ),
        .init(
            title: "RESTful Web APIs",
            subtitle: "Services for a Changing World",
            isbn13: "9781449358068",
            price: 39.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781449358068.png"),
            detailURL: URL(string: "https://itbook.store/books/9781449358068")
        ),
        
        // Core Data & Persistence
        .init(
            title: "Core Data by Tutorials",
            subtitle: "Persisting iOS App Data with Core Data",
            isbn13: "9781950325184",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781950325184.png"),
            detailURL: URL(string: "https://itbook.store/books/9781950325184")
        ),
        .init(
            title: "Realm: Building Modern Swift Apps",
            subtitle: "Build Better Apps Using Realm Database",
            isbn13: "9781950325283",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781950325283.png"),
            detailURL: URL(string: "https://itbook.store/books/9781950325283")
        ),
        
        // Performance & Optimization
        .init(
            title: "High Performance iOS Apps",
            subtitle: "Optimize Your Code for Better Apps",
            isbn13: "9781491911006",
            price: 49.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781491911006.png"),
            detailURL: URL(string: "https://itbook.store/books/9781491911006")
        ),
        .init(
            title: "iOS Performance Tuning",
            subtitle: "Speed Up Your App from the Inside Out",
            isbn13: "9781680506426",
            price: 39.95,
            imageURL: URL(string: "https://itbook.store/img/books/9781680506426.png"),
            detailURL: URL(string: "https://itbook.store/books/9781680506426")
        ),
        
        // Security
        .init(
            title: "iOS Application Security",
            subtitle: "The Definitive Guide for Hackers and Developers",
            isbn13: "9781593276010",
            price: 59.95,
            imageURL: URL(string: "https://itbook.store/img/books/9781593276010.png"),
            detailURL: URL(string: "https://itbook.store/books/9781593276010")
        ),
        .init(
            title: "Hacking with Swift",
            subtitle: "Project-based learning for iOS developers",
            isbn13: "9780993813986",
            price: 39.99,
            imageURL: URL(string: "https://itbook.store/img/books/9780993813986.png"),
            detailURL: URL(string: "https://itbook.store/books/9780993813986")
        ),
        
        // Game Development
        .init(
            title: "2D Apple Games by Tutorials",
            subtitle: "Beginning 2D iOS, tvOS, and macOS Game Development",
            isbn13: "9781950325221",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781950325221.png"),
            detailURL: URL(string: "https://itbook.store/books/9781950325221")
        ),
        .init(
            title: "3D Apple Games by Tutorials",
            subtitle: "Beginning 3D iOS Game Development with Swift",
            isbn13: "9781950325306",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781950325306.png"),
            detailURL: URL(string: "https://itbook.store/books/9781950325306")
        ),
        .init(
            title: "Unity in Action",
            subtitle: "Multiplatform Game Development in C#, 3rd Edition",
            isbn13: "9781617299339",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781617299339.png"),
            detailURL: URL(string: "https://itbook.store/books/9781617299339")
        ),
        
        // Machine Learning & AI
        .init(
            title: "Machine Learning by Tutorials",
            subtitle: "Beginning Machine Learning for iOS Developers",
            isbn13: "9781950325337",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781950325337.png"),
            detailURL: URL(string: "https://itbook.store/books/9781950325337")
        ),
        .init(
            title: "Practical AI with Swift",
            subtitle: "Build ML and AI Apps for iOS",
            isbn13: "9781492044802",
            price: 54.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781492044802.png"),
            detailURL: URL(string: "https://itbook.store/books/9781492044802")
        ),
        
        // AR & VR
        .init(
            title: "ARKit by Tutorials",
            subtitle: "Building Augmented Reality Apps with iOS",
            isbn13: "9781950325320",
            price: 59.99,
            imageURL: URL(string: "https://itbook.store/img/books/9781950325320.png"),
            detailURL: URL(string: "https://itbook.store/books/9781950325320")
        )
    ]
    
    func fetchBookSearch(query: String, page: Int) async throws -> BookSearchList {
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5초
        
        let itemsPerPage = 10
        let startIndex = (page - 1) * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, allMockBooks.count)
        
        guard startIndex < allMockBooks.count else {
            return BookSearchList(
                total: allMockBooks.count,
                page: page,
                books: []
            )
        }
        
        let booksForPage = Array(allMockBooks[startIndex..<endIndex])
        
        print("📚 Mock Repository - 페이지 \(page): \(booksForPage.count)개 반환 (전체: \(allMockBooks.count))")
        
        return BookSearchList(
            total: allMockBooks.count,
            page: page,
            books: booksForPage
        )
    }

    func fetchBookDetail(isbn13: String) async throws -> BookDetail {
        try await Task.sleep(nanoseconds: 300_000_000)
        
        return BookDetail(
            error: 0,
            title: "iOS Programming: The Big Nerd Ranch Guide",
            subtitle: "8th Edition",
            authors: ["Christian Keur", "Aaron Hillegass"],
            publisher: "Big Nerd Ranch Guides",
            isbn10: "0135264022",
            isbn13: isbn13,
            pages: 600,
            year: 2021,
            rating: 4.5,
            desc: """
            Updated for Xcode 12, iOS 14, and Swift 5.3, iOS Programming: The Big Nerd Ranch Guide leads you through the essential concepts, techniques, and tools for developing iOS applications.
            
            After completing this book, you will have the knowledge and confidence to tackle iOS projects of your own. Based on Big Nerd Ranch's popular iOS training and its well-tested materials and methodology, this bestselling guide teaches iOS concepts and coding in tandem.
            
            The result is instruction that is relevant and useful. Throughout the book, the authors explain what's important and share their insights into the larger context of the iOS platform.
            """,
            price: 49.99,
            imageURL: URL(string: "https://itbook.store/img/books/9780135264027.png"),
            detailURL: URL(string: "https://itbook.store/books/9780135264027"),
            pdf: [
                PDFChapter(
                    title: "Chapter 1: A Simple iOS Application",
                    url: URL(string: "https://example.com/pdf/chapter1.pdf")!
                ),
                PDFChapter(
                    title: "Chapter 2: The Swift Language",
                    url: URL(string: "https://example.com/pdf/chapter2.pdf")!
                ),
                PDFChapter(
                    title: "Chapter 3: Views and the View Hierarchy",
                    url: URL(string: "https://example.com/pdf/chapter3.pdf")!
                )
            ]
        )
    }
}
