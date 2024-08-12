//
//  MockBookService.swift
//  MyBookLibraryTests
//
//  Created by Kevin Huang on 10/08/24.
//

import Foundation
@testable import MyBookLibrary

final class MockBookService: BookServiceProtocol {
    var fetchBooksResult: Result<[Book], Error>?
    
    func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        if let result = fetchBooksResult {
            completion(result)
        }
    }
}
