//
//  URLCacheControl.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 10/08/24.
//

import Foundation

protocol CacheControl {
    func hasCache(for request: URLRequest) -> Bool
    func cache(for request: URLRequest) -> Data?
    func storeCache(_ data: Data, for request: URLRequest)
}

final class URLCacheControl: CacheControl {
    private let cache: URLCache
    private let queue: DispatchQueue
    
    init(cache: URLCache = .shared, queueLabel: String = "com.example.URLCacheControlQueue") {
        self.cache = URLCache(memoryCapacity: 100_000_000, diskCapacity: 100_000_000, diskPath: nil)
        self.queue = DispatchQueue(label: queueLabel, attributes: .concurrent)
    }
    
    func hasCache(for request: URLRequest) -> Bool {
        return queue.sync {
            return cache.cachedResponse(for: request) != nil
        }
    }
    
    func cache(for request: URLRequest) -> Data? {
        return queue.sync {
            return cache.cachedResponse(for: request)?.data
        }
    }
    
    func storeCache(_ data: Data, for request: URLRequest) {
        guard let url = request.url else { return }
        queue.async(flags: .barrier) {
            let response = URLResponse(
                url: url,
                mimeType: nil,
                expectedContentLength: data.count,
                textEncodingName: nil
            )
            let cachedUrlResponse = CachedURLResponse(response: response, data: data)
            self.cache.storeCachedResponse(cachedUrlResponse, for: request)
        }
    }
}
