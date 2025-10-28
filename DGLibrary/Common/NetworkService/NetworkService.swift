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
        let request: URLRequest
        
        do {
            request = try endpoint.asURLRequest()
        } catch {
            throw NetworkError.invalidRequest
        }
        
        logger?.log(request: request)
        
        
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await session.data(for: request)
        } catch let urlError as URLError {
            throw handleURLError(urlError)
        } catch {
            throw NetworkError.networkFailure
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
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
    
    private func handleURLError(_ error: URLError) -> NetworkError {
        switch error.code {
        case .notConnectedToInternet, .dataNotAllowed:
            return .noInternetConnection
            
        case .timedOut:
            return .timeout
            
        case .cannotFindHost, .cannotConnectToHost:
            return .serverDown
            
        case .badURL:
            return .invalidURL
            
        default:
            return .networkFailure
        }
    }
}
