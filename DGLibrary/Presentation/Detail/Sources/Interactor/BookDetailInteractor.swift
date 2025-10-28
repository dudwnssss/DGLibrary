//
//  BookDetailInteractor.swift
//  DGLibrary
//
//  Created by 임영준 on 10/26/25.
//

import Foundation

protocol BookDetailInteractor {
    func fetch(request: BookDetailModel.Fetch.Request)
    func selectPDF(request: BookDetailModel.PDF.Request)
}


