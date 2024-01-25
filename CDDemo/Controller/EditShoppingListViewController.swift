//
//  EditShoppingListViewController.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/25/24.
//

import UIKit

class EditShoppingListViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: - Properties
    
    var shoppingList: ShoppingList?
    
    lazy var editShoppingListViewModel: EditShoppingListViewModel = {
        let viewModel = EditShoppingListViewModel()
        viewModel.editShoppingListViewModelDelegate = self
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
    
    
    @IBAction func saveChangesButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else { return }
        let isSuccess = editShoppingListViewModel.updateShoppingList(shoppingList: shoppingList!, name: name)
        
        if isSuccess {
            self.navigationController?.popViewController(animated: true)
        }
    }
}


extension EditShoppingListViewController: EditShoppingListViewModelDelegate {
    
}
