//
//  FavoritesManager.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 11/08/24.
//

import Foundation

protocol FavoritesStorage {
    func saveFavorites(_ favorites: [Int])
    func loadFavorites() -> [Int]
}

final class UserDefaultsStorage: FavoritesStorage {
    private let favoritesKey = "Favorites"

    func saveFavorites(_ favorites: [Int]) {
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }

    func loadFavorites() -> [Int] {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
    }
}

final class FavoritesManager {
    private var favorites: Set<Int>
    private let storage: FavoritesStorage

    init(storage: FavoritesStorage = UserDefaultsStorage()) {
        self.storage = storage
        self.favorites = Set(storage.loadFavorites())
    }

    @discardableResult
    func toggleFavorite(for bookId: Int) -> Bool {
        if favorites.contains(bookId) {
            favorites.remove(bookId)
        } else {
            favorites.insert(bookId)
        }
        storage.saveFavorites(Array(favorites))
        return favorites.contains(bookId)
    }

    func isFavorite(bookId: Int) -> Bool {
        return favorites.contains(bookId)
    }

    func getAllFavorites() -> [Int] {
        return Array(favorites)
    }
}
