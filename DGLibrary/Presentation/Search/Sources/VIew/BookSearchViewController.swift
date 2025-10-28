//
//  BookSearchViewController.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import UIKit

final class BookSearchViewController: UIViewController {
    var interactor: BookSearchInteractor?
    
    private let mainView: BookSearchView = .init()
    
    private var displayedBooks: [BookSearchModel.DisplayedBook] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
    }
    
    private func setProperties() {
        self.navigationItem.searchController = mainView.searchController
        self.navigationItem.title = "Search"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        mainView.searchController.searchBar.delegate = self
        
        mainView.tableView.register(BookSearchTableViewCell.self, forCellReuseIdentifier: BookSearchTableViewCell.reuseIdentifier)
        mainView.tableView.dataSource = self
        mainView.tableView.prefetchDataSource = self
        mainView.tableView.delegate = self
    }
}

extension BookSearchViewController: BookSearchDisplay {
    func displaySearchResults(viewModel: BookSearchModel.Fetch.ViewModel) {
        self.displayedBooks = viewModel.books
        mainView.tableView.reloadData()
    }

    func displayMoreBooks(viewModel: BookSearchModel.Next.ViewModel) {
        let startIndex = displayedBooks.count
        self.displayedBooks.append(contentsOf: viewModel.books)
        
        let indexPaths = (startIndex..<displayedBooks.count).map {
            IndexPath(row: $0, section: 0)
        }
        mainView.tableView.performBatchUpdates {
            mainView.tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    func displayEmptyAlert(viewModel: BookSearchModel.Empty.ViewModel) {
        let alert = UIAlertController(
            title: "No Results",
            message: "No results found for '\(viewModel.query)'.\nPlease check your spelling.",
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(confirmAction)
        
        present(alert, animated: true)
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
    
    func displayLoading(viewModel: BookSearchModel.Loading.ViewModel) {
        if viewModel.isLoading {
            switch viewModel.type {
            case .fullscreen:
                mainView.fullScreenIndicator.startAnimating()
                mainView.tableView.isUserInteractionEnabled = false
            case .paging:
                mainView.tableView.tableFooterView = mainView.pagingLoadingView
            }
        } else {
            mainView.fullScreenIndicator.stopAnimating()
            mainView.tableView.isUserInteractionEnabled = true
            mainView.tableView.tableFooterView = nil
        }
    }
}

extension BookSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        
        searchBar.text = trimmedText
        
        let request: BookSearchModel.Fetch.Request = .init(query: trimmedText)
        interactor?.search(request: request)
//        searchBar.resignFirstResponder()
    }
}

extension BookSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BookSearchTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? BookSearchTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(with: displayedBooks[indexPath.row])
        
        return cell
    }
}

extension BookSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request: BookSearchModel.Select.Request = .init(index: indexPath.row)
        interactor?.select(request: request)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension BookSearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row >= displayedBooks.count - 3 {
                let request = BookSearchModel.Next.Request()
                
                interactor?.next(request: request)
                
                return
            }
        }
    }
}
