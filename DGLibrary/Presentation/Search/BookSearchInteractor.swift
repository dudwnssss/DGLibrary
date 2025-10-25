//
//  BookSearchInteractor.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import Foundation

protocol BookSearchInteractor {
    func search(request: BookSearchModel.Fetch.Request) async -> BookSearchModel.Fetch.Response
    func next(request: BookSearchModel.Next.Request) async -> BookSearchModel.Next.Response
    func select(request: BookSearchModel.Select.Request)
}
