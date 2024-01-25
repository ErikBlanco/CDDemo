//
//  ViewController.swift
//  CDDemo
//
//  Created by Erik Blanco on 1/24/24.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    
    lazy var shoppingListViewModel: ShoppingListViewModel = {
        let viewModel = ShoppingListViewModel()
        viewModel.shoppingListDelegate = self
        return viewModel
    }()
    
    //MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenInitialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shoppingListViewModel.fetchShoppingLists()
    }
    
    //MARK: - Screen initial setup
    
    func screenInitialSetup() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - Add button tapped
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: SegueConstants.addShoppingListId, sender: self)
    }
    
    //MARK: - Prepare for segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ShoppingListDetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.shoppingList = shoppingListViewModel.shoppingLists[indexPath.row]
            }
        }
    }
}

//MARK: - Shopping list view model delegate

extension ShoppingListViewController: ShoppingListViewModelDelegate {
    func updateUI() {
        tableView.reloadData()
    }
}

//MARK: - Table view data source

extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingListViewModel.shoppingLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = shoppingListViewModel.shoppingLists[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.confirmationDialog(indexPath: indexPath)
        }
        
        let edit = UIContextualAction(style: .destructive, title: "Edit") { _, _, _ in
            let storyboard: UIStoryboard = UIStoryboard(name: StoryboardConstants.main, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: StoryboardConstants.EditShoppingListViewController) as? EditShoppingListViewController {
                vc.shoppingList = self.shoppingListViewModel.shoppingLists[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }

        edit.backgroundColor =  .lightGray
        
        let swipe = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipe
    }
    
    func confirmationDialog(indexPath: IndexPath) {
        let alert = UIAlertController(
            title: "Are you sure you want to delete this shopping list?",
            message: "This action cannot be undone.",
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(
            title: "Delete",
            style: .destructive,
            handler: { _ in
                let isSuccess = self.shoppingListViewModel.deleteShoppingList(byShoppingListId: self.shoppingListViewModel.shoppingLists[indexPath.row].id)
                if isSuccess {
                    self.shoppingListViewModel.shoppingLists.remove(at: indexPath.row)
                }
            }))
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: { _ in }))
        present(alert,
                animated: true,
                completion: nil
        )
    }
}


//MARK: - Table view delegate

extension ShoppingListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueConstants.shoppingListDetailId, sender: self)
    }
}

