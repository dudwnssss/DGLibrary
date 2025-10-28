//
//  BookDetailModel.swift
//  DGLibrary
//
//  Created by 임영준 on 10/26/25.
//

import Foundation

enum BookDetailModel {
    struct DisplayedBook {
        let title: String
        let subtitle: String
        let authors: String
        let publisher: String
        let isbn10: String
        let isbn13: String
        let pages: String
        let year: String
        let rating: String
        let desc: String
        let price: String
        let imageURL: URL?
        let detailUrl: URL?
        let pdfs: [PDFChapter]
    }
    
    enum Fetch {
        struct Request {
            let isbn13: String
        }
        struct Response {
            let book: BookDetail
        }
        struct ViewModel {
            let book: DisplayedBook
        }
    }
    
    enum PDF {
        struct Request {
            let pdfURL: URL
        }
        struct Resopnse {
            let pdfURL: URL
        }
    }
    
    enum Loading {
        struct ViewModel {
            let isLoading: Bool
        }
    }
}
