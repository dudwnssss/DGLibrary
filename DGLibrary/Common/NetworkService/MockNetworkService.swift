//
//  MockNetworkService.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//

import Foundation

final class MockNetworkService: NetworkService {
    var mockResult: Result<Any, Error>?
    
    func request<T: Decodable>(_ endpoint: any URLRequestConvertible) async throws -> T {
        guard let result = mockResult else {
            throw NetworkError.decodingError
        }
        
        switch result {
        case .success(let data):
            return data as! T
        case .failure(let error):
            throw error
        }
    }
}
