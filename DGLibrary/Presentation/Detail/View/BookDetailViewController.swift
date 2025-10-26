//
//  BookDetailViewController.swift
//  DGLibrary
//
//  Created by 임영준 on 10/26/25.
//

import UIKit

final class BookDetailViewController: UIViewController {
    let mainView = BookDetailView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
    }
}
