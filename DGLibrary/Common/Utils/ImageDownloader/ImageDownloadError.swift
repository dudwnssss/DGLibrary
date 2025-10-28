//
//  ImageDownloadError.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//

import Foundation

enum ImageDownloadError: Error {
    case invalidResponse
    case serverError(statusCode: Int)
    case invalidData
}
