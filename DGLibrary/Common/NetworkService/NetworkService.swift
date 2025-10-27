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
    private let logger: NetworkLogger?
    
    init(
        session: URLSession = .shared,
        logger: NetworkLogger? = DefaultNetworkLogger()
    ) {
        self.session = session
        self.logger = logger
    }
    
    func request<T: Decodable>(_ endpoint: any URLRequestConvertible) async throws -> T {
        let request = try endpoint.asURLRequest()
        
        logger?.log(request: request)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError(statusCode: 0)
        }
        
        logger?.log(response: httpResponse, data: data)
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            logger?.log(error: error)
            throw NetworkError.decodingError
        }
    }
}
