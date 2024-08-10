//
//  BookService.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 04/08/24.
//

import Foundation

protocol BookServiceProtocol {
    func fetchBooks() async throws -> [Book]
}

final class BookService: BookServiceProtocol {
    private let networkSession: NetworkSession
    private let url: URL
    
    init(networkSession: NetworkSession, url: URL) {
        self.networkSession = networkSession
        self.url = url
    }
    
    func fetchBooks() async throws -> [Book] {
        let request = networkSession.request(url)
        let data = try await request.responseData()
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(customDateFormatter)
        
        let books = try decoder.decode([Book].self, from: data)
        return books
    }
    
    private let customDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()
}
