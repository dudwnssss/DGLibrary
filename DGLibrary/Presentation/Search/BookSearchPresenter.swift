//
//  BookSearchPresenter.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import Foundation

protocol BookSearchPresenter {
    func presentSearchBooks(request: BookSearchModel.Fetch.Response)
    func presentNextBooks(request: BookSearchModel.Next.Response)
    func presentBookDetail(request: BookSearchModel.Select.Response)
}
