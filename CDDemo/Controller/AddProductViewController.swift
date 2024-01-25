//
//  AddProductViewController.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/25/24.
//

import UIKit

class AddProductViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    //MARK: - Properties
    
    var shoppingListId: UUID?
    
    lazy var addProductViewModel: AddProductViewModel = {
        let viewModel = AddProductViewModel()
        viewModel.addProductViewModelDelegate = self
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
    
    //MARK: - Add product button tapped
    
    @IBAction func addProductButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text else { return }
        guard let temp = priceTextField.text as? NSString else { return }
        
        addProductViewModel.createProduct(shoppingListId: shoppingListId!, productName: name, productPrice: temp.floatValue)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension AddProductViewController: AddProductViewModelDelegate {
    
}
