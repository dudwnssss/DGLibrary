//
//  NetworkError.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//


import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
}
