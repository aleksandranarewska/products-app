//
//  URLBuilder.swift
//  ProductFetch
//
//  Created by Aleksandra Narewska on 01/03/2023.
//

import Foundation

protocol URLBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}

enum ProductURL {
    case getProducts
    case getProduct(product : String)
}

extension ProductURL: URLBuilder {
    
    var baseUrl: URL {
        return URL(string: "https://dummyjson.com")!
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        case .getProduct(product: _):
            return "/products/search"
        }
    }
    
    var urlRequest: URLRequest {
        switch self {
        case .getProducts:
            return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
        case .getProduct(product: let product):
            var urlComponents = URLComponents(url: self.baseUrl.appendingPathComponent(self.path), resolvingAgainstBaseURL: true)
            urlComponents?.queryItems = [
                URLQueryItem(name: "q", value: product),
            ]
            if let url = urlComponents?.url {
                return URLRequest(url: url)
            }
            return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
        }
    }
}
