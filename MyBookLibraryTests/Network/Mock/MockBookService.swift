//
//  MockBookService.swift
//  MyBookLibraryTests
//
//  Created by Kevin Huang on 10/08/24.
//

import Foundation
@testable import MyBookLibrary

class MockBookService: BookServiceProtocol {
    var books: [Book] = []
    var error: Error?
    var fetchBooksCallCount = 0
    
    func fetchBooks(completion: @escaping (Result<[MyBookLibrary.Book], any Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        }
        
        completion(.success(books))
    }
}
