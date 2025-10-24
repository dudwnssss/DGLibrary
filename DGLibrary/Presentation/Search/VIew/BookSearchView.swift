//
//  BookSearchView.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import UIKit

final class BookSearchView: UIView {
    private(set) var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색어를 입력하세요"
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    
    private(set) var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
