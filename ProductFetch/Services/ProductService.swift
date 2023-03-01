//
//  ProductService.swift
//  ProductFetch
//
//  Created by Aleksandra Narewska on 01/03/2023.
//

import Foundation
import Combine

protocol Requestable {
    func request(from endpoint: ProductURL) -> AnyPublisher<ProductResponse, DownloadError>
}

struct ProductService: Requestable {
    
    func request(from endpoint: ProductURL) -> AnyPublisher<ProductResponse, DownloadError> {
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<ProductResponse, DownloadError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown)
                        .eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: ProductResponse.self, decoder: jsonDecoder)
                        .mapError {_ in .decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .errorCode(response.statusCode))
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
