//
//  BookSearchInteractor.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import Foundation

protocol BookSearchInteractor {
    func search(request: BookSearchModel.Fetch.Request)
    func next(request: BookSearchModel.Next.Request)
    func select(request: BookSearchModel.Select.Request)
}


