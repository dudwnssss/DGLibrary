//
//  BookDetailBuilder.swift
//  DGLibrary
//
//  Created by 임영준 on 10/26/25.
//

import UIKit

enum BookDetailBuilder {
    static func build(isbn13: String) -> UIViewController {
        let viewController = BookDetailViewController(isbn13: isbn13)
        let presenter = DefaultBookDetailPresenter()
        
        let networkService = DefaultNetworkService()
        let repository = DefaultBookRepository(networkService: networkService)
        let interactor = DefaultBookDetailInteractor(repository: repository)
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
