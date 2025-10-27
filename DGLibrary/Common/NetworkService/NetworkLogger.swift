//
//  NetworkLogger.swift
//  DGLibrary
//
//  Created by 임영준 on 10/27/25.
//

import Foundation

protocol NetworkLogger {
    func log(request: URLRequest)
    func log(response: HTTPURLResponse, data: Data)
    func log(error: Error)
}

final class DefaultNetworkLogger: NetworkLogger {
    func log(request: URLRequest) {
        #if DEBUG
        print("🌐 ===== REQUEST =====")
        print("🔹 URL: \(request.url?.absoluteString ?? "nil")")
        print("🔹 Method: \(request.httpMethod ?? "nil")")
        
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            print("🔹 Headers:")
            headers.forEach { key, value in
                print("   \(key): \(value)")
            }
        }
        
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("🔹 Body:")
            print(prettyPrintJSON(bodyString))
        }
        print("====================\n")
        #endif
    }
    
    func log(response: HTTPURLResponse, data: Data) {
        #if DEBUG
        print("✅ ===== RESPONSE =====")
        print("🔹 URL: \(response.url?.absoluteString ?? "nil")")
        print("🔹 Status Code: \(response.statusCode)")
        
        if let headers = response.allHeaderFields as? [String: Any], !headers.isEmpty {
            print("🔹 Headers:")
            headers.forEach { key, value in
                print("   \(key): \(value)")
            }
        }
        
        print("🔹 Data:")
        if let jsonString = String(data: data, encoding: .utf8) {
            print(prettyPrintJSON(jsonString))
        }
        print("======================\n")
        #endif
    }
    
    func log(error: Error) {
        #if DEBUG
        print("❌ ===== ERROR =====")
        print("🔹 Error: \(error.localizedDescription)")
        print("===================\n")
        #endif
    }
    
    private func prettyPrintJSON(_ jsonString: String) -> String {
        guard let data = jsonString.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data),
              let prettyData = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted, .sortedKeys]),
              let prettyString = String(data: prettyData, encoding: .utf8) else {
            return jsonString
        }
        return prettyString
    }
}
