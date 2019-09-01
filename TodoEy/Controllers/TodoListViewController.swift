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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        loadItems()
        
        
        
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
    
        self.saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField  = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.item.append(newItem)
    
            self.saveItems()
            
            
        }
        alert.addTextField { (aletTextField) in
            aletTextField.placeholder = "Create new Item"
            textField = aletTextField
            
            
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    // Save data
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(item)
            try data.write(to: dataFilePath!)
        } catch  {
            print("Error handling : \(error)" )
        }
        
        self.tableView.reloadData()
   
    }
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
               item = try decoder.decode([Item].self, from: data)
            } catch  {
                print("Decoding error: \(error)")
            }
        }
    }
}

