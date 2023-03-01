//
//  ContentView.swift
//  ProductFetch
//
//  Created by Aleksandra Narewska on 01/03/2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject var viewModel = ProductViewModel(service: ProductService())
    @State private var searchText = ""
    
    var body: some View {
        
        Group {
            
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error) {
                    self.viewModel.getProducts()
                }
            case .success(let content):
                NavigationStack {
                    if content.isEmpty {
                        VStack {
                            Text("No results for search")
                            Button("Get all products") {
                                self.searchText = ""
                                self.viewModel.getProducts()
                            }
                        }
                    }else{
                        ProductsGridView(content : content)
                    }
                }.searchable(text: $searchText, suggestions: {
                    Button("Get all") {
                        self.searchText = ""
                        self.viewModel.getProducts()
                    }
                })
                .onSubmit(of: .search, self.searchForProduct)
                
            }
        }
        .onAppear {
            self.viewModel.getProducts()
        }
    }
    func searchForProduct(){
        self.viewModel.getProducts(for: searchText)
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

