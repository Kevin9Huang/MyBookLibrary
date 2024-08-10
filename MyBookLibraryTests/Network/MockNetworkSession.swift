//
//  MockNetworkSession.swift
//  MyBookLibraryTests
//
//  Created by Kevin Huang on 09/08/24.
//

import Foundation
@testable import MyBookLibrary

final class MockNetworkSession: NetworkSession {
    var requestedUrl = [URL]()
    private let request: MockNetworkRequest
    
    init(request: MockNetworkRequest = MockNetworkRequest()) {
        self.request = request
    }
    
    func request(_ url: URL) -> NetworkRequest {
        requestedUrl.append(url)
        return request
    }
    
    func setReturnData(_ data: Data) {
        request.mockData = data
    }
}
