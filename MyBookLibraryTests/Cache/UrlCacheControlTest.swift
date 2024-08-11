//
//  UrlCacheControlTest.swift
//  MyBookLibraryTests
//
//  Created by Kevin Huang on 10/08/24.
//

import Foundation
import XCTest
@testable import MyBookLibrary

final class URLCacheControlTest: XCTestCase {
    private let testURL1 = URL(string: "https://api.example.com/books")!
    private let testURL2 = URL(string: "https://api.example.com/books/detail")!
    private var cache: URLCache!
    private var sut: URLCacheControl!
    
    override func setUp() {
        super.setUp()
        cache = URLCache(memoryCapacity: 100_000_000, diskCapacity: 100_000_000, diskPath: nil)
        sut = URLCacheControl(cache: cache)
    }
    
    override func tearDown() {
        cache.removeAllCachedResponses()
        cache = nil
        sut = nil
        super.tearDown()
    }
    
    func testHasCache_WhenCacheExists() {
        let data = "Test Data".data(using: .utf8)!
        let request = URLRequest(url: testURL1)
        let response = URLResponse(
            url: request.url!,
            mimeType: nil,
            expectedContentLength: data.count,
            textEncodingName: nil
        )
        let cachedResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedResponse, for: request)
        
        XCTAssertTrue(sut.hasCache(for: request))
        
        let request2 = URLRequest(url: testURL2)
        XCTAssertFalse(sut.hasCache(for: request2))
    }
    
    func testHasCacheWhenCacheDoesNotExist() {
        let request = URLRequest(url: testURL1)
        XCTAssertFalse(sut.hasCache(for: request))
    }
    
    func testCacheWhenCacheExists() {
        let data = "Test Data".data(using: .utf8)!
        let request = URLRequest(url: testURL1)
        let response = CachedURLResponse(response: URLResponse(), data: data)
        cache.storeCachedResponse(response, for: request)
        
        let cachedData = sut.cache(for: request)
        XCTAssertEqual(cachedData, data)
    }
    
    func testCacheWhenCacheDoesNotExist() {
        let request = URLRequest(url: testURL1)
        XCTAssertNil(sut.cache(for: request))
    }
    
    func testStoreCache() {
        let data = "New Test Data".data(using: .utf8)!
        let request = URLRequest(url: testURL1)
        sut.storeCache(data, for: request)
        
        XCTAssertEqual(sut.cache(for: request), data)
    }
    
    func testStoreCache_ShouldUpdateData() {
        let data = "New Test Data".data(using: .utf8)!
        let request = URLRequest(url: testURL1)
        sut.storeCache(data, for: request)
        
        let data2 = "Other Test Data".data(using: .utf8)!
        sut.storeCache(data, for: request)
        
        XCTAssertEqual(sut.cache(for: request), data2)
    }
}
