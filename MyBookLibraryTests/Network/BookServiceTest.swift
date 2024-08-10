//
//  BookServiceTest.swift
//  MyBookLibraryTests
//
//  Created by Kevin Huang on 04/08/24.
//

import XCTest
@testable import MyBookLibrary

class BookServiceTest: XCTestCase {
    func testInit() {
        let (_, mockSession) = makeSut()
        XCTAssertEqual(mockSession.requestedUrl.count, 0, "When init should not hit any api")
    }
    
    func testWhenInit_shouldNotRequestUrl() {
        let (_, spySession) = makeSut()
        
        XCTAssertEqual(spySession.requestedUrl.count, 0)
    }
    
    func testFetchBooks() async throws {
        let (successData, books) = mockSuccessData()
        let (sut, mockSession) = makeSut()
        mockSession.setReturnData(successData)
        // 1st try
        let result = try await sut.fetchBooks()
        XCTAssertEqual(mockSession.requestedUrl.count, 1)
        XCTAssertEqual(result, books)

        // 2nd try
        let (emptyArrayData, _) = mockEmptyArrayData()
        mockSession.setReturnData(emptyArrayData)
        let result2 = try await sut.fetchBooks()
        XCTAssertEqual(mockSession.requestedUrl.count, 2)
        XCTAssertTrue(result2.isEmpty)
    }
    
    private func makeSut() -> (BookService, MockNetworkSession) {
        let mockSession = MockNetworkSession()
        let sut = BookService(
            networkSession: mockSession,
            url: URL(string: "https://www.huang.com")!
        )
        trackForMemoryLeaks(sut)
        return (sut, mockSession)
    }
    
    private func mockSuccessData() -> (Data, [Book]) {
        let data = successResponse.data(using: .utf8)!
        return (data, decodeBooks(from: data)!)
    }
    
    private func mockEmptyArrayData() -> (Data, [Book]) {
        ("[]".data(using: .utf8)!, [])
    }
    
    private func decodeBooks(from jsonData: Data) -> [Book]? {
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .formatted(customDateFormatter)
        return try? decoder.decode([Book].self, from: jsonData)
    }
    
    private let customDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()
    
    private var successResponse = """
    [
      {
        "id": 1,
        "title": "To Kill a Mockingbird",
        "author": "Harper Lee",
        "description": "A classic of modern American literature that has been celebrated for its finely crafted characters and brilliant storytelling.",
        "cover": "https://m.media-amazon.com/images/I/51IXWZzlgSL._SX330_BO1,204,203,200_.jpg",
        "publicationDate": "1960-07-11T00:00:00.000Z"
      },
      {
        "id": 2,
        "title": "The Great Gatsby",
        "author": "F. Scott Fitzgerald",
        "description": "The story of Jay Gatsby, a self-made millionaire, and his pursuit of the American Dream.",
        "cover": "https://m.media-amazon.com/images/I/41NssxNlPlS._SY291_BO1,204,203,200_QL40_FMwebp_.jpg",
        "publicationDate": "1925-04-10T00:00:00.000Z"
      }
    ]
"""
}

private extension URL {
    static func sample() -> URL {
        let randomBookId = Int.random(in: 0...100)
        return URL(string: "https://www.huang.com/book/\(randomBookId)")!
    }
}
