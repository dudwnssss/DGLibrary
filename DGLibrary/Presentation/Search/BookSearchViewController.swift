//
//  BookSearchViewController.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import UIKit

final class BookSearchViewController: UIViewController {
    let mainView: BookSearchView = .init()
    
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
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
}

extension BookSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension BookSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}



