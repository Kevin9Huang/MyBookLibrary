//
//  BookListLoader.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 04/08/24.
//

import Foundation

final class BookListLoader {
    typealias BookListFetcher = (URL) async -> Result<Data, Error>
    private let fetcher: BookListFetcher
    
    init(fetcher: @escaping BookListFetcher) {
        self.fetcher = fetcher
    }
    
    func load(url: URL) async -> Data {
        return fetcher(url)
    }
}
