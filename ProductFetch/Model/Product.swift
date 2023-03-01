//
//  Product.swift
//  ProductFetch
//
//  Created by Aleksandra Narewska on 01/03/2023.
//

import Foundation
struct Product : Codable, Hashable{
    let id : Int?
    let title : String?
    let price : Int?
    let brand : String?
    let thumbnail : String?
}

extension Product {
    
    static var dummyData: Product {
        .init(id: 2,
              title: "phone",
              price: 37,
              brand: "NBC News",
              thumbnail: "https://i.dummyjson.com/data/products/1/thumbnail.jpg")
    }
}
