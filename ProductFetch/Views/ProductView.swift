//
//  ProductView.swift
//  ProductFetch
//
//  Created by Aleksandra Narewska on 01/03/2023.
//

import SwiftUI
import UIKit

struct ProductView: View {
    
    let product: Product
    
    var body: some View {
        
        if let image = product.thumbnail,
           let url = URL(string: image),
           let price = product.price{
            
            VStack(alignment: .center, spacing: 4) {
                CustomImageView(url: url)
                Text(product.title ?? "")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold)).multilineTextAlignment(.center)
                Text(product.brand ?? "")
                    .foregroundColor(.gray)
                    .font(.system(size: 12, weight: .regular)).multilineTextAlignment(.center)
                Text("$\(price)")
                    .foregroundColor(.black)
                    .font(.system(size: 12, weight: .semibold)).multilineTextAlignment(.center)
            }
        }
        
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: Product.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
