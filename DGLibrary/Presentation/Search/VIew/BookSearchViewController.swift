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
    
    private var displayedBooks: [BookSearchModel.Fetch.ViewModel.DisplayedBook] = []
    
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
        
    }

    func displayError() {
        
    }
}

extension BookSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text,
              !query.isEmpty else { return }
        
        let request: BookSearchModel.Fetch.Request = .init(query: query)
        interactor?.search(request: request)
        searchBar.resignFirstResponder()
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
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request: BookSearchModel.Select.Request = .init(index: indexPath.row)
        interactor?.select(request: request)
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
