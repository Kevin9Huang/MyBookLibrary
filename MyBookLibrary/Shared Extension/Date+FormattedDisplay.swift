//
//  Date+FormattedDisplay.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 11/08/24.
//

import Foundation

extension Date {
    func getCustomFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"

        return dateFormatter.string(from: self)
    }
}
