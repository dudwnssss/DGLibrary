//
//  BookSearchPresenterTests.swift
//  DGLibraryTests
//
//  Created by 임영준 on 10/28/25.
//

import XCTest
@testable import DGLibrary

final class BookSearchPresenterTests: XCTestCase {
    var sut: DefaultBookSearchPresenter!
    var viewController: MockBookSearchViewController!
    var router: MockBookSearchRouter!
    
    
    override func setUp() {
        super.setUp()
        sut = DefaultBookSearchPresenter()
        viewController = MockBookSearchViewController()
        router = MockBookSearchRouter()
        
        sut.viewController = viewController
        sut.router = router
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        router = nil
        super.tearDown()
    }
    
    func test_검색_결과를_ViewModel로_변환() {
        let title = "Swift Programming"
        let price = 49.99
        let expectedFormattedPrice = "$49.99"
        
        let books = [
            BookSearch(
                title: title,
                subtitle: "The Big Nerd Ranch Guide",
                isbn13: "9780135264041",
                price: price,
                imageURL: URL(string: "https://test.com/image.jpg"),
                detailURL: nil
            )
        ]
        let response = BookSearchModel.Fetch.Response(
            books: books,
            totalCount: 100,
            currentPage: 1
        )
        
        sut.presentSearchBooks(response: response)
        
        XCTAssertTrue(viewController.didCallDisplaySearchResults)
        XCTAssertEqual(viewController.capturedViewModel?.books.count, 1)
        
        let displayedBook = viewController.capturedViewModel?.books[0]
        XCTAssertEqual(displayedBook?.title, title)
        XCTAssertEqual(displayedBook?.price, expectedFormattedPrice)
    }
        
    func test_detail_이동_요청() {
        let isbn = "1234567890123"
        let response = BookSearchModel.Select.Response(isbn13: isbn)
        
        sut.presentBookDetail(response: response)
        
        XCTAssertTrue(router.didCallNavigateToDetail)
        XCTAssertEqual(router.capturedISBN, isbn)
    }
    
    func test_error_메시지_출력() {
        let error = NetworkError.serverError(statusCode: 500)
        let description = error.localizedDescription.description
        
        sut.presentError(error: error)
        
        XCTAssertTrue(viewController.didCallDisplayError)
        XCTAssertEqual(viewController.capturedMessage, description)
    }

}
