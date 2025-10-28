//
//  QueryValidator.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//

import Foundation

enum QueryError: LocalizedError {
    case empty
    case tooShort(minimum: Int)
    
    var errorDescription: String? {
        switch self {
        case .empty:
            return "검색어를 입력해주세요"
        case .tooShort(let minimum):
            return "검색어는 최소 \(minimum)글자 이상 입력해주세요"
        }
    }
}

struct QueryValidator {
    private let minimumLength: Int = 2
    
    func validate(_ query: String) throws {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else {
            throw QueryError.empty
        }
        
        guard trimmed.count >= minimumLength else {
            throw QueryError.tooShort(minimum: minimumLength)
        }
        
        return
    }
}
