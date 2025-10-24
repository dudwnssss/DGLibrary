//
//  BookSearchViewModel.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import Foundation

enum BookSearchModel {
    enum Fetch {
        struct Request {}
        struct Response {}
        struct ViewModel {
            struct DisplayedBook {
                let title: String
                let subTitle: String
                let isbn3: String
                let price: String
                let imageURL: String
                let detailURL: String
            }
            let books: [DisplayedBook]
        }
    }
}
