//
//  URLRequestConvertible.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import Foundation

public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}
