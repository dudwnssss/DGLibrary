//
//  BookAPI.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import Foundation

enum BookAPI {
    case search(query: String, page: Int)
    case detail(isbn13: String)
}

extension BookAPI: URLRequestConvertible {
    var baseURL: String {
        Secrets.apiURL
    }
    
    var path: String {
        switch self {
        case .search(let query, let page):
            return "/search/\(sanitizeForPath(query))/\(page)"
            
        case .detail(let isbn13):
            return "/books/\(isbn13)"
        }
    }
    
    var method: String {
        switch self {
        case .search, .detail:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = 30
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    private func sanitizeForPath(_ string: String) -> String {
        let sanitized = string
            .replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: "/", with: "-")
        
        return sanitized.addingPercentEncoding(
            withAllowedCharacters: .urlPathAllowed
        ) ?? sanitized
    }
}


