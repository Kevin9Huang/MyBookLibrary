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
    let bookDescription: String
    let cover: String
    let publicationDate: Date
    
    //Saved local book
    var isFromLocal: Bool = false
    var localImageData: Data? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case bookDescription = "description"
        case cover
        case publicationDate
    }
}
