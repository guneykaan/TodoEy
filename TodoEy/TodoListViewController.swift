//
//  ViewController.swift
//  TodoEy
//
//  Created by Güneyhan Kurşat on 29.07.2019.
//  Copyright © 2019 Güneyhan Kurşat. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    
    var item = ["Find Mike" , "Buy Eggs", "Destroy Demogorgon"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = item[indexPath.row]
        
        return cell
        
    }
    
    // MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField  = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            self.item.append(textField.text!)
            self.tableView.reloadData()
        }
        alert.addTextField { (aletTextField) in
            aletTextField.placeholder = "Create new Item"
            textField = aletTextField
            
            
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}

