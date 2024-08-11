//
//  FetchBookService.swift
//  MyBookLibrary
//
//  Created by Kevin Huang on 11/08/24.
//

import Foundation
import Alamofire

protocol BookServiceProtocol {
    func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void)
}

class BookService: BookServiceProtocol {
    private let cache: URLCache
    private let session: Session
    private let adapter: BookAdapterProtocol
    
    init(session: Session = .default, 
         cache: URLCache = .shared,
         adapter: BookAdapterProtocol = BookAdapter()) {
        self.session = session
        self.cache = cache
        self.adapter = adapter
    }
    
    func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        let url = URL(string: "https://my-json-server.typicode.com/cutamar/mock/books")!
        let request = URLRequest(url: url)
        
        if let cachedResponse = cache.cachedResponse(for: request) {
            print("Found cache")
            do {
                let books = try adapter.adapt(data: cachedResponse.data)
                completion(.success(books))
            }
            catch {
                //TODO: use enum error instead
                completion(.failure(NSError(domain: "com.bookservice.error", code: 1001, userInfo: nil)))
            }
        } else {
            print("@@@ fetching datae")
            session.request(request).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let books = try self.adapter.adapt(data: data)
                        let cachedResponse = CachedURLResponse(response: response.response!, data: data)
                        self.cache.storeCachedResponse(cachedResponse, for: request)
                        completion(.success(books))
                    }
                    catch {
                        //TODO: use enum error instead
                        completion(.failure(NSError(domain: "com.bookservice.error", code: 1001, userInfo: nil)))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
