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
        let category = categories[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductsTableViewCell
        cell.productImage.image = UIImage(systemName: "person.fill")
        cell.productNameLabel.text = category.name
        return cell
    }


}
