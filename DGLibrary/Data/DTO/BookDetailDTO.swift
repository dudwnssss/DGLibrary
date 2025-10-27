//
//  BookDetailDTO.swift
//  DGLibrary
//
//  Created by 임영준 on 10/24/25.
//

///Link: https://api.itbook.store/

import Foundation

struct BookDetailDTO: Decodable {
    ///문서에는 옵셔널에 대한 명세가 없기에 전체 속성이 옵셔널 가능성 있는 상태이나, 편의 상 구현 후 예외처리
    
    let error: String
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
    let image: String
    let url: String
    let pdf: [String: String]
}

extension BookDetailDTO {
    func toDomain() -> BookDetail {
        return BookDetail(
            error: 0,
            title: self.title,
            subtitle: self.subtitle,
            authors: [],
            publisher: self.publisher,
            isbn10: self.isbn10,
            isbn13: self.isbn13,
            pages: 0,
            year: 0,
            rating: 0,
            desc: self.desc,
            price: 0,
            imageURL: nil,
            detailURL: nil,
            pdf: []
        )
    }
}
