//
//  ProductViewModel.swift
//  ProductFetch
//
//  Created by Aleksandra Narewska on 01/03/2023.
//

import Foundation
import Combine

protocol Productable {
    func getProducts(for searchTerm : String?)
}

enum ResultState {
    case loading
    case failed(error: Error)
    case success(content: [Product])
}


class ProductViewModel: ObservableObject, Productable {
    
    private let service: ProductService
    
    private(set) var products = [Product]()
    @Published private(set) var state: ResultState = .loading
    
    private var cancellables = Set<AnyCancellable>()
    
    init(service: ProductService) {
        self.service = service
    }
    
    func getProducts(for searchTerm : String? = nil) {
        
        var request : ProductURL = .getProducts
        
        if let search = searchTerm {
            request = .getProduct(product: search)
        }
        self.state = .loading
        
        let cancellable = self.service
            .request(from: request)
            .sink { (res) in
                switch res {
                case .failure(let error):
                    self.state = .failed(error: error)
                case .finished:
                    self.state = .success(content: self.products)
                }
            } receiveValue: { res in
                if let receivedProducts = res.products{
                    self.products = receivedProducts
                }
            }
        self.cancellables.insert(cancellable)
    }
}
