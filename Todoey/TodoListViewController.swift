//
//  ViewController.swift
//  Todoey
//
//  Created by Ian DeBoo on 4/10/19.
//  Copyright © 2019 Ian DeBoo. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray : [String] = []
    
    let defaults = UserDefaults.standard
    //this accesses a small storage area allocated to each app that will retain default settings across app launches
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
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
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
//////////////////////////////////////////////////////////////////////////////////
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
//////////////////////////////////////////////////////////////////////////////////
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            self.itemArray.append(textField.text!)
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

