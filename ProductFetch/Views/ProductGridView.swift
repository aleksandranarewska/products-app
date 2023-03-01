//
//  ProductGridView.swift
//  ProductFetch
//
//  Created by Aleksandra Narewska on 01/03/2023.
//

import SwiftUI

struct ProductsGridView: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    let content : [Product]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(content, id: \.self) { product in
                    ProductView(product: product)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitle("Products")
    }
}

struct ProductsGridView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsGridView(content: [Product.dummyData])
    }
}

