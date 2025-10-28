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
    func presentEmptyResult(response: BookSearchModel.Empty.Response)
    func presentError(error: Error)
    func presentLoading(response: BookSearchModel.Loading.Response)
    func presentHideLoading(response: BookSearchModel.Loading.Response)
}


