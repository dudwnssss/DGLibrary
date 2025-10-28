//
//  BookRepositoryTests.swift
//  DGLibraryTests
//
//  Created by 임영준 on 10/28/25.
//

import XCTest
@testable import DGLibrary

final class BookRepositoryTests: XCTestCase {
    var sut: DefaultBookRepository!
    var networkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        networkService = MockNetworkService()
        sut = DefaultBookRepository(networkService: networkService)
    }
    
    override func tearDown() {
        networkService = nil
        sut = nil
        super.tearDown()
    }
    
    func test_book_search_성공시_DTO_Entity_변환() async throws {
        let dto = BookSearchListDTO(
            total: "100",
            page: "1",
            books: [.init(
                title: "Swift",
                subtitle: "SubTitle",
                isbn13: "1234567890123",
                price: "$29.99",
                image: "",
                url: ""
            )]
        )
        networkService.mockResult = .success(dto)
        
        let result = try await sut.fetchBookSearch(query: "swift", page: 1)
        let expectedTotal = 100
        let expectedPage = 1
        let expectedBookCount = 1
        let expectedFirstBookPrice = 29.99
        
        XCTAssertEqual(result.total, expectedTotal)
        XCTAssertEqual(result.page, expectedPage)
        XCTAssertEqual(result.books.count, expectedBookCount)
        XCTAssertEqual(result.books.first?.price, expectedFirstBookPrice)
    }
    
    func test_book_detail_성공시_DTO_Entity_변환() async throws {
        let dto = BookDetailDTO(
            error: "0",
            title: "Securing DevOps",
            subtitle: "Security in the Cloud",
            authors: "Julien Vehent, Kim, Lim",
            publisher: "Manning",
            isbn10: "1617294136",
            isbn13: "9781617294136",
            pages: "384",
            year: "2018",
            rating: "5",
            desc: "An application running in the cloud can benefit from incredible efficiencies, but they come with unique security threats too. A DevOps team's highest priority is understanding those risks and hardening the system against them.Securing DevOps teaches you the essential techniques to secure your cloud...",
            price: "$26.98",
            image: "https://itbook.store/img/books/9781617294136.png",
            url: "https://itbook.store/books/9781617294136",
            pdf: [
                "Chapter 2": "https://itbook.store/files/9781617294136/chapter2.pdf",
                "Chapter 5": "https://itbook.store/files/9781617294136/chapter5.pdf"
            ]
        )
        
        networkService.mockResult = .success(dto)
        
        let result = try await sut.fetchBookDetail(isbn13: "123")
        let expectedAuthors = ["Julien Vehent", "Kim", "Lim"]
        let expectedPage = 384
        let expectedYear = 2018
        let expectedRating = 5.0
        let expectedPrice = 26.98
        
        XCTAssertEqual(result.authors, expectedAuthors)
        XCTAssertEqual(result.pages, expectedPage)
        XCTAssertEqual(result.year, expectedYear)
        XCTAssertEqual(result.rating, expectedRating)
        XCTAssertEqual(result.price, expectedPrice)
    }
    
    func test_네트워크_에러_발생시_에러_전파() async {
        networkService.mockResult = .failure(NetworkError.serverError(statusCode: 500))
        
        do {
            _ = try await sut.fetchBookSearch(query: "swift", page: 1)
            XCTFail("error should be thrown")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}
