//
//  String+MD5.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//

import Foundation
import CryptoKit

extension String {
    func md5() -> String {
        let digest = Insecure.MD5.hash(data: Data(self.utf8))
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
