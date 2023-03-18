//
//  CategoriesTableViewController.swift
//  StoreApp
//
//  Created by Ahmet Ali ÇETİN on 19.03.2023.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    private var categories: [CategoryModel] = []
    private var client = StoreHTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        Task {
            await populateCategories()
        }
    }
    
    private func populateCategories() async {
        
        do {
            categories = try await client.getAllCategories()
            tableView.reloadData()
            tableView.dataSource = self
            print(categories )
        } catch {
            
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductsTableViewCell
        let category = categories[indexPath.row]
        
        if let url = URL(string: category.image),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        cell.productNameLabel.text = category.name
                        cell.productImage.image = image
                    }
                
        }
        
        return cell
    }


}
