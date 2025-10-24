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

