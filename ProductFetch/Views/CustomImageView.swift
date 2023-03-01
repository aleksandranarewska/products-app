//
//  CustomImageView.swift
//  ProductFetch
//
//  Created by Aleksandra Narewska on 01/03/2023.
//

import SwiftUI

struct CustomImageView: View {
    var url: URL
    @ObservedObject var imageLoader = ImageLoaderService()
    @State var image: UIImage = UIImage()
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:100, height:100)
            .onReceive(imageLoader.$image) { image in
                self.image = image
            }
            .onAppear {
                imageLoader.loadImage(for: url)
            }
    }
}

struct CustomImageView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageView(url: URL(string: "https://i.dummyjson.com/data/products/1/thumbnail.jpg")!)
    }
}
