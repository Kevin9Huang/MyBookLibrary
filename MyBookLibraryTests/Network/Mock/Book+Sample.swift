//
//  Book+Sample.swift
//  MyBookLibraryTests
//
//  Created by Kevin Huang on 10/08/24.
//

import Foundation
@testable import MyBookLibrary

extension Book {
    static func sample() -> Book {
        let randomId = Int.random(in: 1...1000)
        return Book(
            id: Int.random(in: 1...1000),
            title: "Title \(randomId)",
            author: "Author \(randomId)",
            description:  "Description for book \(randomId).",
            cover: URL(string: "https://www.example.com/image\(randomId).jpg")!,
            publicationDate: Date().addingTimeInterval(-TimeInterval.random(in: 0...1_000))
        )
    }
}
