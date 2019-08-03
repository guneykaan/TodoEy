//
//  ViewController.swift
//  TodoEy
//
//  Created by Güneyhan Kurşat on 29.07.2019.
//  Copyright © 2019 Güneyhan Kurşat. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    
    var item = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let items = defaults.array(forKey: "ToDoList") as? [Item] {
            item = items
        }
        
        let newItem = Item()
        newItem.title = "Me"
        
        let newItem2 = Item()
        newItem2.title = "Myself"
        
        let newItem3 = Item()
        newItem3.title = "And"
        
        let newItem4 = Item()
        newItem4.title = "I"
    }

    //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let myItem = item[indexPath.row]
        
        
        cell.textLabel?.text = item[indexPath.row].title
        
        cell.accessoryType = myItem.done ? .checkmark : .none
        
        return cell
        
    }
    
    // MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        item[indexPath.row].done = !item[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField  = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.item.append(newItem)
            self.defaults.set(self.item, forKey: "ToDoList")
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

