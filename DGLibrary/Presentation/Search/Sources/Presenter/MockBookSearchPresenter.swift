//
//  MockBookSearchPresenter.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import Foundation

final class MockBookSearchPresenter: BookSearchPresenter {
    var didCallPresentSearchBooks = false
    var didCallPresentError = false
    var didCallPresentNextBooks = false
    var didCallPresentBookDetail = false
    
    var capturedResponse: BookSearchModel.Fetch.Response?
    var capturedNextResponse: BookSearchModel.Next.Response?
    var capturedDetailResponse: BookSearchModel.Select.Response?
    var capturedError: Error?
    
    func presentSearchBooks(response: BookSearchModel.Fetch.Response) {
        didCallPresentSearchBooks = true
        capturedResponse = response
    }

    func presentNextBooks(response: BookSearchModel.Next.Response) {
        didCallPresentNextBooks = true
        capturedNextResponse = response
    }

    func presentBookDetail(response: BookSearchModel.Select.Response) {
        didCallPresentBookDetail = true
        capturedDetailResponse = response
    }

    func presentError(error: any Error) {
        didCallPresentError = true
        capturedError = error
    }
}
