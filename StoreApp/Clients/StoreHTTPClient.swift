//
//  StoreHTTPClient.swift
//  StoreApp
//
//  Created by Ahmet Ali ÇETİN on 19.03.2023.
//

import Foundation

class StoreHTTPClient {
    
    func getProductsByCategories(categoryID: Int) async throws -> [ProductModel] {
        let (data, response) = try await URLSession.shared.data(from: URL.productsByCategory(categoryID))
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
        
        let jsonDecoder = JSONDecoder()
        
        guard let products = try? jsonDecoder.decode([ProductModel].self, from: data) else {
            throw NetworkError.decodingError
        }
        return products
         
    }
    
    
    func getAllCategories() async throws -> [CategoryModel] {
        
        let (data, response) = try await URLSession.shared.data(from: URL.allCategories)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidServerResponse
        }
        
        let jsonDecoder = JSONDecoder()
        
        guard let category = try?  jsonDecoder.decode([CategoryModel].self, from: data) else {
            throw NetworkError.decodingError
        }
        return category
        
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case decodingError
}
