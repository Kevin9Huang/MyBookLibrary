//
//  FavoritesManagerTest.swift
//  MyBookLibraryTests
//
//  Created by Kevin Huang on 11/08/24.
//

import Foundation
import XCTest
@testable import MyBookLibrary

class MockFavoritesStorage: FavoritesStorage {
    var storage: [Int] = []

    func saveFavorites(_ favorites: [Int]) {
        storage = favorites
    }

    func loadFavorites() -> [Int] {
        return storage
    }
}

class FavoritesManagerTests: XCTestCase {

    func testToggleFavorite() {
        let mockStorage = MockFavoritesStorage()
        let manager = FavoritesManager(storage: mockStorage)

        XCTAssertTrue(manager.toggleFavorite(for: 1))
        XCTAssertTrue(manager.isFavorite(bookId: 1))
        XCTAssertEqual(manager.getAllFavorites(), [1])

        XCTAssertFalse(manager.toggleFavorite(for: 1))
        XCTAssertFalse(manager.isFavorite(bookId: 1))
        XCTAssertEqual(manager.getAllFavorites(), [])
    }

    func testGetAllFavorites() {
        let mockStorage = MockFavoritesStorage()
        let manager = FavoritesManager(storage: mockStorage)
        
        manager.toggleFavorite(for: 1)
        manager.toggleFavorite(for: 2)
        manager.toggleFavorite(for: 3)
        
        let favorites = manager.getAllFavorites()
        XCTAssertEqual(favorites.count, 3)
        XCTAssertTrue(favorites.contains(1))
        XCTAssertTrue(favorites.contains(2))
        XCTAssertTrue(favorites.contains(3))
    }
}
