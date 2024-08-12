//
//  MockBookSaver.swift
//  MyBookLibraryTests
//
//  Created by Kevin Huang on 12/08/24.
//

import XCTest
@testable import MyBookLibrary

final class MockBookSaver: BookSaverProtocol {
    var savedBooks: [Book] = []
    
    func saveBook(_ book: MyBookLibrary.Book, completion: (() -> Void)?) {
        savedBooks.append(book)
    }
    
    func getAllBooks() -> [Book] {
        return savedBooks
    }
}
