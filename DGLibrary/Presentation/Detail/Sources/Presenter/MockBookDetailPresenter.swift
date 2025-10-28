//
//  MockBookDetailPresenter.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//

import Foundation

final class MockBookDetailPresenter: BookDetailPresenter {
    var didCallPresentDetailBook: Bool = false
    var didCallPresentPDF: Bool = false
    var didCallPresentError: Bool = false
    
    var capturedFetchResponse: BookDetailModel.Fetch.Response?
    var capturedPDFResponse: BookDetailModel.SelectPDF.Resopnse?
    var capturedError: Error?
    
    func presentDetailBook(response: BookDetailModel.Fetch.Response) {
        didCallPresentDetailBook = true
        capturedFetchResponse = response
    }

    func presentPDF(response: BookDetailModel.SelectPDF.Resopnse) {
        didCallPresentPDF = true
        capturedPDFResponse = response
    }

    func presentError(error: any Error) {
        didCallPresentError = true
        capturedError = error
    }
    
    func presentLoading() {
        
    }

    func presentHideLoading() {
        
    }
    
    func presentExternalURL(response: BookDetailModel.openURL.Response) {
        
    }
}
