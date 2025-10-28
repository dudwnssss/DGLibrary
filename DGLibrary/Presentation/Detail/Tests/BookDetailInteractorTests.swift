//
//  BookDetailInteractorTests.swift
//  DGLibraryTests
//
//  Created by 임영준 on 10/28/25.
//

import XCTest
@testable import DGLibrary

final class BookDetailInteractorTests: XCTestCase {
    var interactor: DefaultBookDetailInteractor!
    var repository: MockBookRepository!
    var presenter: MockBookDetailPresenter!
    
    override func setUp() {
        super.setUp()
        presenter = MockBookDetailPresenter()
        repository = MockBookRepository()
        interactor = DefaultBookDetailInteractor(repository: repository)
        interactor.presenter = presenter
    }
    
    override func tearDown() {
        interactor = nil
        repository = nil
        presenter = nil
        super.tearDown()
    }
    
    func test_fetch_성공시_presenter에게_결과_전달() async {
        let expectedBook = BookDetail(
            error: 0,
            title: "title",
            subtitle: "",
            authors: [],
            publisher: "",
            isbn10: "",
            isbn13: "",
            pages: 0,
            year: 0,
            rating: 0,
            desc: "",
            price: 0,
            imageURL: nil,
            detailURL: nil,
            pdf: []
        )
        
        repository.mockDetailResult = .success(expectedBook)
        
        interactor.fetch(request: .init(isbn13: "123"))
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertEqual(repository.fetchDetailCallCount, 1)
        XCTAssertEqual(repository.lastRequestedISBN, "123")
        
        XCTAssertTrue(presenter.didCallPresentDetailBook)
        XCTAssertEqual(presenter.capturedFetchResponse?.book.title, "title")
    }
    
    func test_fetch_실패시_에러_처리() async {
        repository.mockDetailResult = .failure(NetworkError.serverError(statusCode: 500))
        
        interactor.fetch(request: .init(isbn13: "123"))
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertTrue(presenter.didCallPresentError)
    }
    
    func test_selectPDF_presenter에게_결과_전달() {
        let url = URL(string: "https://www.dg.com")!
        
        interactor.selectPDF(request: .init(pdfURL: url))
        XCTAssertTrue(presenter.didCallPresentPDF)
        XCTAssertEqual(presenter.capturedPDFResponse?.pdfURL, url)
    }
}
