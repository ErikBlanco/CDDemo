//
//  ShoppingListDetailViewController.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/25/24.
//

import UIKit

class ShoppingListDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var totalProductsLabel: UILabel!
    
    //MARK: - Properties
    var shoppingList: ShoppingList?
    
    lazy var viewModel: ShoppingListDetailViewModel = {
        return ShoppingListDetailViewModel(shoppingListDetailViewModelDelegate: self, selectedShoppingList: shoppingList!)
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        screenInitialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchShoppingList()
    }
    
    //MARK: - Screen initial setup
    
    func screenInitialSetup() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
//        tableView.rowHeight = 70
    }
    
    private func updateLabels() {
        navTitle.title = viewModel.shoppingList.name
        totalProductsLabel.text = "Total products: \(viewModel.shoppingList.products.count)"
        let totalCost = viewModel.shoppingList.products.reduce(0, { x, y in
            x + y.price
        })
        totalCostLabel.text = "Total cost: $\(totalCost)"
    }
    
    @IBAction func addProductButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: SegueConstants.addProductId, sender: self)
    }
    
    //MARK: - Prepare for segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? AddProductViewController {
            destinationVC.shoppingListId = shoppingList!.id
        }
    }
    
}

//MARK: - Table view data source

extension ShoppingListDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.shoppingList.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell {
            let product = viewModel.shoppingList.products[indexPath.row]
            cell.nameLabel.text = "\(product.name)"
            cell.priceLabel.text = "$\(product.price)"
            
            return cell
        }
        return UITableViewCell()
    }
}

extension ShoppingListDetailViewController: ShoppingListDetailViewModelDelegate {
    func updateUI() {
        updateLabels()
        tableView.reloadData()
    }
}
