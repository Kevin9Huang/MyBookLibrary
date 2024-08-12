//
//  BookAdapterTest.swift
//  MyBookLibraryTests
//
//  Created by Kevin Huang on 12/08/24.
//

import XCTest
@testable import MyBookLibrary

final class BookAdapterTests: XCTestCase {

    private func makeSut() -> BookAdapter {
        let sut = BookAdapter()
        trackForMemoryLeaks(sut)
        return sut
    }

    func testAdapt_ValidData_ReturnsBooks() {
        let sut = makeSut()
        let jsonData = """
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
        """.data(using: .utf8)!
        
        do {
            let books = try sut.adapt(data: jsonData)
            
            XCTAssertEqual(books.count, 2)
            XCTAssertEqual(books[0].title, "To Kill a Mockingbird")
            XCTAssertEqual(books[1].title, "The Great Gatsby")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
    
    func testAdapt_InvalidData_ThrowsError() {
        let sut = makeSut()
        let jsonData = """
        {
            "invalid": "data"
        }
        """.data(using: .utf8)!
        
        XCTAssertThrowsError(try sut.adapt(data: jsonData)) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }
}
