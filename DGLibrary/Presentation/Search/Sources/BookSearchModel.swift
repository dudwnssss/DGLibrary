//
//  BookSearchViewModel.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

import Foundation

enum BookSearchModel {
    struct DisplayedBook {
        let title: String
        let subtitle: String
        let isbn13: String
        let price: String
        let imageURL: URL?
        let detailURL: URL?
    }
    
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
            let books: [DisplayedBook]
        }
    }
    
    enum Next {
        struct Request {}
        struct Response {
            let books: [BookSearch]
        }
        struct ViewModel {
            let books: [DisplayedBook]
        }
    }
    
    enum Select {
        struct Request {
            let index: Int
        }
        struct Response {
            let isbn13: String
        }
    }
    
    enum Loading {
        struct Response {
            let type: LoadingType
        }
        
        struct ViewModel {
            let isLoading: Bool
            let type: LoadingType
        }
        
        enum LoadingType {
            case fullscreen
            case paging
        }
    }
}
