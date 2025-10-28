//
//  BookDetailPresenterTests.swift
//  DGLibraryTests
//
//  Created by 임영준 on 10/28/25.
//

import XCTest
@testable import DGLibrary

final class BookDetailPresenterTests: XCTestCase {
    var sut: DefaultBookDetailPresenter!
    var viewController: MockBookDetailViewController!
    var router: MockBookDetailRouter!
    
    override func setUp() {
        super.setUp()
        sut = DefaultBookDetailPresenter()
        viewController = MockBookDetailViewController()
        router = MockBookDetailRouter()
        
        sut.viewController = viewController
        sut.router = router
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        viewController = nil
        router = nil
    }
    
    func test_fetch_결과를_ViewModel로_변환() {
        let book = BookDetail(
            error: 0,
            title: "Swift Programming",
            subtitle: "The Big Nerd Ranch Guide",
            authors: ["Kim, Lim"],
            publisher: "some pulisher",
            isbn10: "1234567890",
            isbn13: "1234567890123",
            pages: 123,
            year: 1998,
            rating: 4.9,
            desc: "nice and awesome book",
            price: 49.99,
            imageURL: nil,
            detailURL: nil,
            pdf: [
                .init(title: "chater1", url: nil),
                .init(title: "chater2", url: nil)
            ]
        )
        
        let response = BookDetailModel.Fetch.Response(book: book)
        
        sut.presentDetailBook(response: response)
        
        let expectedAuthors = "Kim, Lim"
        let expectedPrice = "$49.99"
        let expectedRating = "★ 4.9"
        XCTAssertTrue(viewController.didCallDisplayDetailResult)
        
        let displayedBook = viewController.capturedViewModel?.book
        XCTAssertEqual(displayedBook?.authors, expectedAuthors)
        XCTAssertEqual(displayedBook?.price, expectedPrice)
        XCTAssertEqual(displayedBook?.rating, expectedRating)
    }
    
    func test_pdf_이동_요청() {
        let url = URL(string: "www.naver.com")!
        let response = BookDetailModel.PDF.Resopnse(pdfURL: url)
        
        sut.presentPDF(response: response)
        
        XCTAssertTrue(router.didCallPresentPDF)
        XCTAssertEqual(router.capturedPDFURL, url)
    }
    
    func test_error_메시지_출력() {
        let error = NetworkError.serverError(statusCode: 500)
        let description = error.localizedDescription.description
        
        sut.presentError(error: error)
        
        XCTAssertTrue(viewController.didCallDisplayError)
        XCTAssertEqual(viewController.capturedMessage, description)
    }
}
