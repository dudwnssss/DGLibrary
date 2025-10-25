//
//  BookSearchPresenter.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import Foundation

protocol BookSearchPresenter {
    func presentSearchBooks(response: BookSearchModel.Fetch.Response)
    func presentNextBooks(response: BookSearchModel.Next.Response)
    func presentBookDetail(response: BookSearchModel.Select.Response)
}
