//
//  BookSearchDTO.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

///Link: https://api.itbook.store/

import Foundation

struct BookSearchListDTO: Decodable {
    /// 문서에는 옵셔널에 대한 명세가 없기에 전체 속성이 옵셔널 가능성 있는 상태이나, 편의 상 구현 후 예외처리
    
    let total: String
    let page: String
    let books: [BookSearchDTO]
}

extension BookSearchListDTO {
    func toDomain() -> BookSearchList {
        return BookSearchList(
            total: Int(total) ?? 0,
            page: Int(page) ?? 0,
            books: books.map { $0.toDomain() }
        )
    }
}

struct BookSearchDTO: Decodable {
    ///문서에는 옵셔널에 대한 명세가 없기에 전체 속성이 옵셔널 가능성 있는 상태이나, 편의 상 구현 후 예외처리
    
    let title: String
    let subtitle: String
    let isbn13: String
    let price: String
    let image: String
    let url: String
}

extension BookSearchDTO {
    func toDomain() -> BookSearch {
        let price = Double(self.price.trimmingPrefix("$")) ?? 0
        
        return BookSearch(
            title: self.title,
            subtitle: self.subtitle,
            isbn13: self.isbn13,
            price: price,
            imageURL: URL(string: image),
            detailURL: URL(string: url),
        )
    }
}
