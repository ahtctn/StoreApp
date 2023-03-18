//
//  ProductModel.swift
//  StoreApp
//
//  Created by Ahmet Ali ÇETİN on 19.03.2023.
//

import Foundation

struct ProductModel: Codable {
    let id: Int
    let title: String
    let price: Int
    let description: String
    let category: [CategoryModel]
    let images: [URL]?
}
