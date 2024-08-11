//
//  BookListViewModel.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 09/08/24.
//

import Foundation

class BookViewModel {
    private let bookService: BookServiceProtocol
    
    var books: [Book] = [] {
        didSet {
            onBooksUpdated?()
        }
    }
    var onBooksUpdated: (() -> Void)?
    
    init(bookService: BookServiceProtocol) {
        self.bookService = bookService
    }
    
    func onViewDidLoad() {
        bookService.fetchBooks { [weak self] result in
            switch result {
            case .success(let books):
                self?.books = books
            case .failure(let error):
                print("Failed to fetch books: \(error)")
            }
        }
    }
}
