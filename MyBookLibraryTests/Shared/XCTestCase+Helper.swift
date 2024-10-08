//
//  XCTestCase+Helper.swift
//  MyBookLibraryTests
//
//  Created by Kevin Huang on 07/08/24.
//

import Foundation
import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(
        _ instance: AnyObject,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance, "Instance is not dealocated. Potential memory leak",
                file: file,
                line: line
            )
        }
    }
}
