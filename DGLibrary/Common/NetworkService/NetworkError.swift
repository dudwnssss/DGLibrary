//
//  NetworkError.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//


import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidRequest

    case noInternetConnection
    case networkFailure
    case timeout
    
    case serverError(statusCode: Int)
    case serverDown
    
    case invalidResponse
    case decodingError
    case emptyData
    
    case unknown(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL, .invalidRequest:
            return "요청 정보가 올바르지 않습니다."
            
        case .noInternetConnection:
            return "인터넷 연결을 확인해주세요."
            
        case .timeout:
            return "요청 시간이 초과되었습니다. 다시 시도해주세요."
            
        case .networkFailure:
            return "네트워크 오류가 발생했습니다."
            
        case .serverDown:
            return "서버에 일시적인 문제가 발생했습니다. 잠시 후 다시 시도해주세요."
            
        case .serverError(let statusCode):
            return "서버 오류가 발생했습니다. (코드: \(statusCode))"
            
        case .invalidResponse:
            return "서버 응답이 올바르지 않습니다."
            
        case .decodingError:
            return "데이터 처리 중 오류가 발생했습니다."
            
        case .emptyData:
            return "데이터가 비어있습니다."
            
        case .unknown(let error):
            return "알 수 없는 오류가 발생했습니다: \(error.localizedDescription)"
        }
    }
}
