//
//  ShoppingListDetailViewController.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/24/24.
//

import UIKit

class AddShoppingListViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: - Properties
    
    lazy var addShoppingListViewModel: AddShoppingListViewModel = {
        let viewModel = AddShoppingListViewModel()
        viewModel.addShoppingListDelegate = self
        return viewModel
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        screenInitialSetup()
    }
    
    //MARK: - Screen initial setup
    func screenInitialSetup() {

    }
    
    //MARK: - Create shopping list button tapped
    @IBAction func createShoppingListBtnTapped(_ sender: UIButton) {
        if let name = nameTextField.text {
            addShoppingListViewModel.createShoppingList(name: name)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension AddShoppingListViewController: AddShoppingListViewModelDelegate {
    
}
