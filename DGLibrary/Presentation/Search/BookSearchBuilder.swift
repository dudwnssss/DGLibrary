//
//  BookSearchBuilder.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import UIKit

enum BookSearchBuilder {
    static func build() -> UIViewController {
        let viewController = BookSearchViewController()
        let presenter = DefaultBookSearchPresenter()
        let router = DefaultBookSearchRouter()
        
        let repository = MockBookRepository()
        let interactor = DefaultBookSearchInteractor(repository: repository)
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        router.viewController = viewController
        
        return viewController
    }
}
