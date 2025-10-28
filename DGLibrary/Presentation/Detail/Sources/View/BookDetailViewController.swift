//
//  BookDetailViewController.swift
//  DGLibrary
//
//  Created by 임영준 on 10/26/25.
//

import UIKit

final class BookDetailViewController: UIViewController {
    var interactor: BookDetailInteractor?
    private let isbn13: String
    private let mainView = BookDetailView()
    
    init(isbn13: String) {
        self.isbn13 = isbn13
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        interactor?.fetch(request: .init(isbn13: isbn13))
    }
    
    private func setProperties() {
        self.title = "Detail"
        mainView.onMenuSelected = { [weak self] url in
            self?.interactor?.selectPDF(request: .init(pdfURL: url))
        }
        mainView.linkButton
            .addTarget(self, action: #selector(onLinkButtontapped), for: .touchUpInside)
    }
    
    @objc func onLinkButtontapped() {
        interactor?.openURL()
    }
}

extension BookDetailViewController: BookDetailDisplay {
    func displayDetailResult(viewModel: BookDetailModel.Fetch.ViewModel) {
        mainView.configure(with: viewModel.book)
    }

    func displayError(message: String) {
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(confirmAction)
        
        present(alert, animated: true)
    }
    
    func displayLoading(viewModel: BookDetailModel.Loading.ViewModel) {
        if viewModel.isLoading {
            mainView.indicator.startAnimating()
        } else {
            mainView.indicator.stopAnimating()
        }
    }
    
    func displayExternalURL(viewModel: BookDetailModel.openURL.ViewModel) {
        UIApplication.shared.open(viewModel.url)
    }
}
