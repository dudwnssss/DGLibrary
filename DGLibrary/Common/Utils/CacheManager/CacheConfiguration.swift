//
//  CacheConfiguration.swift
//  DGLibrary
//
//  Created by 임영준 on 10/28/25.
//

import Foundation

enum CacheConfiguration {
    /// 캐시 디렉토리 이름
    static let cacheFolderName = "DGLibraryImageCache"
    
    /// 전체 메모리의 25% (Kingfisher 기본값)
    static var memoryCacheLimit: Int {
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        return Int(totalMemory) / 4
    }
    
    /// 디스크 캐시 최대 용량: 100MB
    static var diskCacheLimit: Int {
        return 100 * 1024 * 1024
    }
    
    /// 디스크 캐시 정리 후 목표 용량: 80MB (80%)
    static var diskCacheTargetSize: Int {
        return Int(Double(diskCacheLimit) * 0.8)
    }
    
    /// 다스크 캐시 만료 기간: 7일
    static let cacheExpiration: TimeInterval = 7 * 24 * 60 * 60
    
    
    /// 다운로드 타임아웃: 30초
    static let downloadTimeout: TimeInterval = 30
}
