//
//  BookSaverManager.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 12/08/24.
//

import Foundation
import CoreData
import UIKit

protocol BookSaverProtocol {
    func saveBook(_ book: Book, completion: () -> Void)
    func getAllBooks() -> [Book]
}

final class BookSaverManager: BookSaverProtocol {
    private let persistentContainer: NSPersistentContainer

    init(container: NSPersistentContainer = NSPersistentContainer(name: "BookDataModel")) {
        self.persistentContainer = container
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }

    func saveBook(_ book: Book, completion: () -> Void) {
        let context = persistentContainer.viewContext
        let bookEntity = BookEntity(context: context)
        bookEntity.id = Int16(book.id)
        bookEntity.title = book.title
        bookEntity.author = book.author
        bookEntity.publicationDate = book.publicationDate

        do {
            try context.save()
            completion()
            print("Saved book: \(book)")
        } catch {
            print("Failed to save book: \(error)")
        }
    }

    func getAllBooks() -> [Book] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()

        do {
            let bookEntities = try context.fetch(fetchRequest)
            return bookEntities.compactMap { entity -> Book? in
                guard let title = entity.title,
                      let author = entity.author,
                      let publicationDate = entity.publicationDate else { return nil }

                let id = Int(entity.id)
                var book = Book(
                    id: id,
                    title: title,
                    author: author,
                    bookDescription: entity.bookDescription ?? "",
                    cover: "",
                    publicationDate: publicationDate
                )
                book.isFromLocal = true
                return book
            }
        } catch {
            print("Failed to fetch books: \(error)")
            return []
        }
    }
}
