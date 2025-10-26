//
//  BookSearchViewModel.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import Foundation

enum BookSearchModel {
    enum Fetch {
        struct Request {
            let query: String
        }
        struct Response {
            let books: [BookSearch]
            let totalCount: Int
            let currentPage: Int
        }
        struct ViewModel {
            struct DisplayedBook {
                let title: String
                let subTitle: String
                let isbn13: String
                let price: String
                let imageURL: String
                let detailURL: String
            }
            let books: [DisplayedBook]
        }
    }
    
    enum Next {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
    
    enum Select {
        struct Request {
            let index: Int
        }
        struct Response {
            let isbn13: String
        }
    }
}
