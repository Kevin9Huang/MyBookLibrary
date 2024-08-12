//
//  BookSaverManagerTest.swift
//  MyBookLibraryTests
//
//  Created by Kevin Huang on 12/08/24.
//

import XCTest
import CoreData
@testable import MyBookLibrary

class BookSaverManagerTests: XCTestCase {
    var bookSaverManager: BookSaverManager!
    var mockPersistentContainer: NSPersistentContainer!

    override func setUp() {
        super.setUp()

        mockPersistentContainer = {
            let container = NSPersistentContainer(name: "BookDataModel")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { _, error in
                if let error = error {
                    fatalError("Failed to load Core Data stack: \(error)")
                }
            }
            return container
        }()

        bookSaverManager = BookSaverManager(container: mockPersistentContainer)
    }

    override func tearDown() {
        super.tearDown()
        bookSaverManager = nil
        mockPersistentContainer = nil
    }

    func testSaveBook() {
        let book = Book(id: 1, title: "Test Title 1", author: "Test Author 1", bookDescription: "Book 1", cover: "https://example.com/cover1.jpg", publicationDate: Date())

        bookSaverManager.saveBook(book)

        let savedBooks = bookSaverManager.getAllBooks()
        XCTAssertEqual(savedBooks.count, 1)
        XCTAssertEqual(savedBooks.first?.title, "Test Title")
    }

    func testGetAllBooks() {
        let book1 = Book(id: 1, title: "Test Title 1", author: "Test Author 1", bookDescription: "Book 1", cover: "https://example.com/cover1.jpg", publicationDate: Date())
        let book2 = Book(id: 2, title: "Test Title 2", author: "Test Author 2", bookDescription: "Book 2", cover: "https://example.com/cover2.jpg", publicationDate: Date())

        bookSaverManager.saveBook(book1)
        bookSaverManager.saveBook(book2)

        let savedBooks = bookSaverManager.getAllBooks()
        XCTAssertEqual(savedBooks.count, 2)
        XCTAssertEqual(savedBooks[0].title, "Test Title 1")
        XCTAssertEqual(savedBooks[1].title, "Test Title 2")
    }
}
