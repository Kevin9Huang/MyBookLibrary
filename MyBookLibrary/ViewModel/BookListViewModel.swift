//
//  BookListViewModel.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 09/08/24.
//

import Foundation

final class BookListViewModel {
    private let bookService: BookServiceProtocol
    private let bookSaver: BookSaverProtocol
    
    var books: [Book] = [] {
        didSet {
            onBooksUpdated?()
        }
    }
    var onBooksUpdated: (() -> Void)?
    
    init(
        bookService: BookServiceProtocol = BookService(),
        bookSaver: BookSaverProtocol = BookSaverManager()
    ) {
        self.bookService = bookService
        self.bookSaver = bookSaver
    }
    
    func loadBooks() {
        var savedBooks = bookSaver.getAllBooks()
        bookService.fetchBooks { [weak self] result in
            switch result {
            case .success(let books):
                savedBooks.append(contentsOf: books)
                self?.books = savedBooks
            case .failure(let error):
                print("Failed to fetch books: \(error)")
            }
        }
        
    }
}
