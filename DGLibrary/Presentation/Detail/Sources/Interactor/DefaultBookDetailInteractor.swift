//
//  DefaultBookDetailInteractor.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//


import Foundation

final class DefaultBookDetailInteractor: BookDetailInteractor {
    var presenter: BookDetailPresenter?
    private let repository: BookRepository
    
    private var pdfs: [PDFChapter] = []
    private var url: URL?
    
    init(repository: BookRepository) {
        self.repository = repository
    }
    
    func fetch(request: BookDetailModel.Fetch.Request) {
        presenter?.presentLoading()
        Task {
            do {
                let result = try await repository.fetchBookDetail(isbn13: request.isbn13)
                let response = BookDetailModel.Fetch.Response(book: result)
                self.pdfs = response.book.pdf
                self.url = response.book.detailURL
                
                await MainActor.run {
                    presenter?.presentHideLoading()
                    presenter?.presentDetailBook(response: response)
                }
            } catch {
                await MainActor.run {
                    presenter?.presentHideLoading()
                    presenter?.presentError(error: error)
                }
            }
        }
    }
    
    func selectPDF(request: BookDetailModel.SelectPDF.Request) {
        let response = BookDetailModel.SelectPDF.Resopnse(pdfURL: request.pdfURL)
        presenter?.presentPDF(response: response)
    }
    
    func openURL() {
        guard let url else { return }
        let response = BookDetailModel.openURL.Response(url: url)
        presenter?.presentExternalURL(response: response)
        
    }
}
