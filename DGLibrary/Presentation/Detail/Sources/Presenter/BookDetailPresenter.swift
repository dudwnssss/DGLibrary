//
//  BookDetailPresenter 2.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//


import Foundation

protocol BookDetailPresenter {
    func presentDetailBook(response: BookDetailModel.Fetch.Response)
    func presentPDF(response: BookDetailModel.PDF.Resopnse)
    func presentError(error: Error)
}