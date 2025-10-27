//
//  NetworkService.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(_ endpoint: URLRequestConvertible) async throws -> T
}

final class DefaultNetworkService: NetworkService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: any URLRequestConvertible) async throws -> T {
        let request = try endpoint.asURLRequest()
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError(statusCode: 0)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingError
        }
    }
}
