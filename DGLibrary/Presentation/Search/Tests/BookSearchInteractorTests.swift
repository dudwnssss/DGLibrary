//
//  BookSearchInteractorTests.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import XCTest
@testable import DGLibrary

final class BookSearchInteractorTests: XCTestCase {
    var sut: DefaultBookSearchInteractor!
    var repository: MockBookRepository!
    var presenter: MockBookSearchPresenter!
    
    override func setUp() {
        super.setUp()
        presenter = MockBookSearchPresenter()
        repository = MockBookRepository()
        sut = DefaultBookSearchInteractor(repository: repository)
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        repository = nil
        presenter = nil
        super.tearDown()
    }
    
    // MARK: - Search Tests
    
    func test_search_성공시_presenter에게_결과_전달() async {
        let expectedBooks = [
            BookSearch(
                title: "Test Book",
                subtitle: "Test Subtitle",
                isbn13: "1234567890123",
                price: 29.99,
                imageURL: nil,
                detailURL: nil
            )
        ]
        
        repository.mockSearchResult = .success(
            BookSearchList(total: 100, page: 1, books: expectedBooks)
        )
        
        sut.search(request: .init(query: "swift"))
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertEqual(repository.fetchCallCount, 1)
        XCTAssertEqual(repository.lastRequestedQuery, "swift")
        XCTAssertEqual(repository.lastRequestedPage, 1)
        
        XCTAssertTrue(presenter.didCallPresentSearchBooks)
        XCTAssertEqual(presenter.capturedResponse?.totalCount, 100)
    }
    
    func test_search_실패시_에러_처리() async {
        repository.mockSearchResult = .failure(NetworkError.serverError(statusCode: 500))
        
        sut.search(request: .init(query: "swift"))
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertTrue(presenter.didCallPresentError)
    }
    
    // MARK: - Next Tests
    
    func test_next_성공시_다음_페이지_로드() async {
        // Given: 첫 검색 완료
        let firstPageBooks = [
            BookSearch(
                title: "Book 1",
                subtitle: "",
                isbn13: "1111111111111",
                price: 10.0,
                imageURL: nil,
                detailURL: nil
            )
        ]
        repository.mockSearchResult = .success(
            BookSearchList(total: 200, page: 1, books: firstPageBooks)
        )
        
        sut.search(request: .init(query: "swift"))
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        // When: 다음 페이지 요청
        let secondPageBooks = [
            BookSearch(
                title: "Book 2",
                subtitle: "",
                isbn13: "2222222222222",
                price: 20.0,
                imageURL: nil,
                detailURL: nil
            )
        ]
        repository.mockSearchResult = .success(
            BookSearchList(total: 200, page: 2, books: secondPageBooks)
        )
        
        sut.next(request: .init())
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        // Then
        XCTAssertEqual(repository.fetchCallCount, 2)
        XCTAssertEqual(repository.lastRequestedPage, 2)
        XCTAssertTrue(presenter.didCallPresentNextBooks)
    }
    
    func test_next_마지막_페이지에서는_요청_안함() async {
        // Given: 전체 1개만 있음
        let books = [
            BookSearch(
                title: "Only Book",
                subtitle: "",
                isbn13: "1111111111111",
                price: 10.0,
                imageURL: nil,
                detailURL: nil
            )
        ]
        repository.mockSearchResult = .success(
            BookSearchList(total: 1, page: 1, books: books)
        )
        
        sut.search(request: .init(query: "swift"))
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        let callCountBefore = repository.fetchCallCount
        
        // When
        sut.next(request: .init())
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        // Then
        XCTAssertEqual(repository.fetchCallCount, callCountBefore)
    }
    
    // MARK: - Select Tests
    
    func test_select_유효한_인덱스_선택() async {
        // Given
        let books = [
            BookSearch(
                title: "Book 1",
                subtitle: "",
                isbn13: "1234567890123",
                price: 10.0,
                imageURL: nil,
                detailURL: nil
            ),
            BookSearch(
                title: "Book 2",
                subtitle: "",
                isbn13: "9876543210987",
                price: 20.0,
                imageURL: nil,
                detailURL: nil
            )
        ]
        repository.mockSearchResult = .success(
            BookSearchList(total: 2, page: 1, books: books)
        )
        
        sut.search(request: .init(query: "swift"))
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        // When
        sut.select(request: .init(index: 0))
        
        // Then
        XCTAssertTrue(presenter.didCallPresentBookDetail)
        XCTAssertEqual(presenter.capturedDetailResponse?.isbn13, "1234567890123")
    }
    
    func test_select_범위_밖_인덱스는_무시() async {
        // Given
        let books = [
            BookSearch(
                title: "Only Book",
                subtitle: "",
                isbn13: "1234567890123",
                price: 10.0,
                imageURL: nil,
                detailURL: nil
            )
        ]
        repository.mockSearchResult = .success(
            BookSearchList(total: 1, page: 1, books: books)
        )
        
        sut.search(request: .init(query: "swift"))
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        // When
        sut.select(request: .init(index: 10))
        
        // Then
        XCTAssertFalse(presenter.didCallPresentBookDetail)
    }
}
