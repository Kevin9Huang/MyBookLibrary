//
//  BookAdapter.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 11/08/24.
//

import Foundation

protocol BookAdapterProtocol {
    func adapt(data: Data) throws -> [Book]
}

final class BookAdapter: BookAdapterProtocol {
    func adapt(data: Data) throws -> [Book] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(customDateFormatter)
        
        return try decoder.decode([Book].self, from: data)
    }
    
    private let customDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()
}
