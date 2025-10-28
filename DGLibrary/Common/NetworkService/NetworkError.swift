//
//  NetworkError.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//


import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case networkFailure
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "잘못된 URL입니다"
        case .noData:
            return "데이터가 없습니다"
        case .decodingError:
            return "데이터 처리 오류가 발생했습니다"
        case .serverError(let statusCode):
            return "서버 오류가 발생했습니다. (코드: \(statusCode))"
        case .networkFailure:
            return "네트워크 연결을 확인해주세요"
        }
    }
}
