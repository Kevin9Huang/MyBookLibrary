//
//  Book.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 04/08/24.
//

import Foundation

struct Book: Codable, Equatable {
    let id: Int
    let title: String
    let author: String
    let description: String
    let cover: URL
    let publicationDate: Date
}
