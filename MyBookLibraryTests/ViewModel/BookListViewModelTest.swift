//
//  BookListViewModelTest.swift
//  MyBookLibraryTests
//
//  Created by Kevin Huang on 12/08/24.
//

import XCTest
@testable import MyBookLibrary

final class BookListViewModelTests: XCTestCase {
    
    private func makeSut() -> (BookListViewModel, MockBookService, MockBookSaver) {
        let mockBookService = MockBookService()
        let mockBookSaver = MockBookSaver()
        let sut = BookListViewModel(
            bookService: mockBookService,
            bookSaver: mockBookSaver
        )
        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(mockBookService)
        trackForMemoryLeaks(mockBookSaver)
        return (sut, mockBookService, mockBookSaver)
    }
    
    func testLoadBooksSuccess() {
        let (sut, mockBookService, mockBookSaver) = makeSut()
        let expectedBooks: [Book] = [.sample(), .sample()]
        
        mockBookService.fetchBooksResult = .success(expectedBooks)
        
        let expectation = XCTestExpectation(description: "Books updated")
        sut.onBooksUpdated = {
            expectation.fulfill()
        }
        
        sut.loadBooks()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(sut.books.count, expectedBooks.count)
        XCTAssertEqual(sut.books[0].title, expectedBooks.first?.title)
        XCTAssertEqual(sut.books[1].title, expectedBooks[1].title)
    }
    
    func testLoadBooksFailure() {
        let (sut, mockBookService, mockBookSaver) = makeSut()
        mockBookService.fetchBooksResult = .failure(NSError(domain: "", code: 0, userInfo: nil))
        
        sut.loadBooks()
        
        XCTAssertTrue(sut.books.isEmpty)
    }
    
    func testLoadBooksWithSavedBooks() {
        let (sut, mockBookService, mockBookSaver) = makeSut()
        let savedBooks: [Book] = [.sample()]
        let fetchedBooks: [Book] = [.sample()]
        mockBookSaver.savedBooks = savedBooks
        mockBookService.fetchBooksResult = .success(fetchedBooks)
        
        let expectation = XCTestExpectation(description: "Books updated")
        sut.onBooksUpdated = {
            expectation.fulfill()
        }
        
        sut.loadBooks()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(sut.books.count, 2)
        XCTAssertEqual(sut.books[0].title, savedBooks.first?.title)
        XCTAssertEqual(sut.books[1].title, fetchedBooks.first?.title)
    }
}
