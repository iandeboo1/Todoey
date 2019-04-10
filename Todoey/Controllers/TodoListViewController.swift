//
//  ViewController.swift
//  Todoey
//
//  Created by Ian DeBoo on 4/10/19.
//  Copyright © 2019 Ian DeBoo. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]
    
    let defaults = UserDefaults.standard
    //this accesses a small storage area allocated to each app that will retain default settings across app launches; storing too much data will cause extremely long app loading times
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let newItem = Item()
        newItem.label = "Eat Poison"
        itemArray.append(newItem)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Items] {
            itemArray = items
        }
        
    }

//////////////////////////////////////////////////////////////////////////////////
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //this line creates the cell item and names it "cell", links to the protype cell with the name "ToDo..."; also make sure that the i in index path is lowercase
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.label
        
        cell.accessoryType = item.done ? .checkmark : .none
        //this is called a Ternary Operator and basically takes the places of and shortens an if-else statement in certain cases
        
        return cell
    }
    
//////////////////////////////////////////////////////////////////////////////////
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
    }
    
//////////////////////////////////////////////////////////////////////////////////
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            
            let newItem = Item()
            newItem.label = textField.text!
            
            self.itemArray.append(newItem)

            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            //this line sets a key value pair to be saved; the first part is the value and the second part is the key name
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField {
            (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}

