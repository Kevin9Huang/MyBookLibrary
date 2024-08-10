//
//  MockNetworkRequest.swift
//  MyBookLibraryTests
//
//  Created by Kevin Huang on 09/08/24.
//

import Foundation
@testable import MyBookLibrary

final class MockNetworkRequest: NetworkRequest {
    var mockData: Data
    
    init(data: Data = Data()) {
        self.mockData = data
    }
    
    func responseData() async throws -> Data {
        return mockData
    }
}
