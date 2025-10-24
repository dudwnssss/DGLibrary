//
//  BookSearchViewController.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import UIKit

final class BookSearchViewController: UIViewController {
    let mainView: BookSearchView = .init()
    
    let mockBooks: [BookSearchModel.Fetch.ViewModel.DisplayedBook] = [
        .init(title: "mockTitle", subTitle: "mockSubTitle", isbn13: "mockIsbn13", price: "mockPrice", imageURL: "mockImageURL", detailURL: "mockDetailURL"),
        .init(title: "mockTitle", subTitle: "mockSubTitle", isbn13: "mockIsbn13", price: "mockPrice", imageURL: "mockImageURL", detailURL: "mockDetailURL")
    ]
    
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
        
        mainView.tableView.register(BookSearchTableViewCell.self, forCellReuseIdentifier: BookSearchTableViewCell.reuseIdentifier)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
}

extension BookSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BookSearchTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? BookSearchTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(with: mockBooks[indexPath.row])
        
        return cell
    }
}

extension BookSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}



